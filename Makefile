#!/usr/bin/make -f
##
# Makefile for Teckhost systems
# See env[TH_SRC] and env[TH_CKSUM] for ISO building
##
export WORKSPACE ?= $(abspath $(PWD)/)
export GRUB_EXTRA ?= hostname=testpc1

# Version Table
debian12_src ?= https://cdimage.debian.org/cdimage/archive/12.4.0/amd64/iso-cd/debian-12.4.0-amd64-netinst.iso
debian12_sha ?= 64d727dd5785ae5fcfd3ae8ffbede5f40cca96f1580aaa2820e8b99dae989d94

##
# ISO
##

# Default release
teckhost.iso: teckhost_debian12.iso
	cp teckhost_debian12.iso teckhost.iso

# Intended for use in production and development
teckhost_%.iso: upstream_%.iso
	./iso/build_iso $(ISOARGS) \
		-i upstream_$*.iso -o teckhost_$*.iso \
		-f iso/$*/grub-bios.cfg -g iso/$*/grub-efi.cfg \
		-x "$(GRUB_EXTRA)" \
		-s iso/$*/preseed.cfg

# Intended for use in automated testing
teckhost-CICD_%.iso: upstream_%.iso iso/%/testseed.cfg
	./iso/build_iso $(ISOARGS) \
		-i upstream_$*.iso -o $@ \
		-f iso/$*/grub-bios.cfg -g iso/$*/grub-efi.cfg \
		-x "$(GRUB_EXTRA)" \
		-s iso/$*/testseed.cfg

# Grab an upstream ISO and validate checksum
upstream_%.iso:
	# Copy iso from parent directory or download fresh copy
	cp "../$($*_sha).iso" ./ || wget --quiet -O "$($*_sha).iso" "$($*_src)"
	# Verify checksum of pristine iso
	echo "$($*_sha)  $($*_sha).iso" | sha256sum -c
	# Move into location to verify success
	mv "$($*_sha).iso" "upstream_$*.iso"


##
# Test/Dev Stuff
##

# Apply minimum patches (hostname, confirmation, etc.) to preseed
iso/%/testseed.cfg: iso/%/preseed.cfg iso/%/preseed_test.patch
	cp iso/$*/preseed.cfg iso/$*/testseed.cfg
	patch iso/$*/testseed.cfg iso/$*/preseed_test.patch


# File modes in git are not reliable
testprep:
	chmod 0700 test/.ssh
	chmod 0600 test/.ssh/id_ed25519

# Create testpc1 and run all {admin,user} tests
test: testpc1_debian12 pytest-testpc1-user pytest-testpc1-admin

# Run user-only tests against a host as user:testuser
pytest-%-user:
	python3 -m pytest \
		--ssh-config=test/.ssh/config \
		--ssh-identity-file=test/.ssh/id_ed25519 \
		--hosts=ssh://testuser@$* \
		--type user

# Run root-required tests against a host as user:testadmin
pytest-%-admin:
	python3 -m pytest \
		--ssh-config=test/.ssh/config \
		--ssh-identity-file=test/.ssh/id_ed25519 \
		--hosts=ssh://testadmin@$* \
		--type admin

# Connect to a host using ssh as user:testadmin
ssh-%-user: testprep
	ssh -F test/.ssh/config -i test/.ssh/id_ed25519 \
		ssh://testuser@$*

# Connect to a host using ssh as user:testadmin
ssh-%-admin: testprep
	ssh -F test/.ssh/config -i test/.ssh/id_ed25519 \
		ssh://testadmin@$*


##
# Virtual Machines
##

# Create a testpc1 image using the specified iso
testpc1_%: teckhost-CICD_%.iso
ifneq (,$(findstring testpc1,$(shell VBoxManage list vms)))
	echo 'VM already exists: testpc1'
else
	./test/vbox_create \
		-i $(WORKSPACE)/teckhost-CICD_$*.iso \
		-n testpc1 \
		-p 4222
endif


##
# Cleanup
##

clean: clean-testpc1
	$(RM) iso/*/testseed.cfg teckhost*.iso

# Delete a VM if it exists
clean-%:
	@if [ -n "$(findstring $*,$(shell VBoxManage list vms))" ]; then \
		VBoxManage controlvm $* poweroff || true; \
		VBoxManage unregistervm $* --delete; \
	else \
		echo "No VMs could match $*; skipping"; \
	fi


.PHONY: testprep test testpc1 clean
