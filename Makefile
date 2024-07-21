#!/usr/bin/make -f
##
# Makefile for Teckhost systems
# See env[TH_SRC] and env[TH_CKSUM] for ISO building
##
export WORKSPACE ?= $(abspath $(PWD)/)

##
# Version Table
##

# Current Debian Stable
debian12_src ?= https://cdimage.debian.org/cdimage/archive/12.5.0/amd64/iso-cd/debian-12.5.0-amd64-netinst.iso
debian12_sha ?= 013f5b44670d81280b5b1bc02455842b250df2f0c6763398feb69af1a805a14f

# Current Ubuntu LTS
ubuntu2204_src ?= https://releases.ubuntu.com/20.04.6/ubuntu-20.04.6-desktop-amd64.iso
ubuntu2204_sha ?= 510ce77afcb9537f198bc7daa0e5b503b6e67aaed68146943c231baeaab94df1

# Latest Test Images
debian12_OVA_src ?= https://storage.googleapis.com/teckhost/testpc1_debian12-v1.2.ova
debian12_OVA_sha ?= 723d7e54f4cf706dafc47a5b80d799b716401c5b4b032e5289cfde2f02d9e63b

##
# ISO
##

# Default release
teckhost.iso: teckhost_debian12.iso
	cp teckhost_debian12.iso teckhost.iso

# Remaster an upstream ISO with teckhost bootstrapping
teckhost_%.iso: upstream_%.iso
	./iso/build_iso $(ISOARGS) -d iso/$* \
		-i upstream_$*.iso -o teckhost_$*.iso

# Grab an upstream ISO and validate checksum
upstream_%.iso:
	# Copy iso from parent directory or download fresh copy
	cp "../$($*_sha).iso" ./ || wget --quiet -O "$($*_sha).iso" "$($*_src)"
	# Verify checksum of pristine iso
	echo "$($*_sha)  $($*_sha).iso" | sha256sum -c
	# Move into location to verify success
	mv "$($*_sha).iso" "upstream_$*.iso"

# Grab an upstream ISO and validate checksum
# TODO: Remove duplication with above
upstream_%.ova:
	# Copy iso from parent directory or download fresh copy
	cp "../$($*_OVA_sha).ova" ./ || wget --quiet -O "$($*_OVA_sha).ova" "$($*_OVA_src)"
	# Verify checksum of pristine ova
	echo "$($*_OVA_sha)  $($*_OVA_sha).ova" | sha256sum -c
	# Move into location to verify success
	mv "$($*_OVA_sha).ova" "upstream_$*.ova"


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
testpc1_%: teckhost_%.iso
ifneq (,$(findstring testpc1,$(shell VBoxManage list vms)))
	echo 'VM already exists: testpc1'
ifeq (,$(findstring testpc1,$(shell VBoxManage list runningvms)))
	VBoxManage startvm testpc1 --type headless && sleep 60
endif
else
	./test/vbox_create \
		-i $(WORKSPACE)/teckhost_$*.iso \
		-n testpc1 -p 4222
endif

# Import a previously-generated test image
import-testpc1_%: upstream_%.ova
ifneq (,$(findstring testpc1,$(shell VBoxManage list vms)))
	echo 'VM already exists: testpc1'
else
	VBoxManage import upstream_$*.ova --vsys 0 \
		--eula accept --vmname testpc1
endif


##
# Cleanup
##

clean: clean-testpc1
	$(RM) -f iso/*/testseed.cfg *.iso *.ova

# Delete a VM if it exists
clean-%:
	@if [ -n "$(findstring $*,$(shell VBoxManage list vms))" ]; then \
		VBoxManage controlvm $* poweroff || true; \
		VBoxManage unregistervm $* --delete; \
	else \
		echo "No VMs could match $*; skipping"; \
	fi


.PHONY: testprep test clean
