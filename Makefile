#!/usr/bin/make -f
##
# Makefile for Teckhost systems
# See env[TH_SRC] and env[TH_CKSUM] for ISO building
##

# Location used for temp/test data
export WORKSPACE ?= $(abspath $(PWD)/)

# Handed to virtualbox during full-test
#export BS_GITREV ?= $(shell git rev-parse HEAD)


##
# ISO
##

# Version Table
debian13_src   ?= https://cdimage.debian.org/cdimage/archive/13.0.0/amd64/iso-cd/debian-13.0.0-amd64-netinst.iso
debian13_sha   ?= e363cae0f1f22ed73363d0bde50b4ca582cb2816185cf6eac28e93d9bb9e1504

# Default release
teckhost.iso: teckhost_debian13.iso
	cp teckhost_debian13.iso teckhost.iso

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


##
# Default Test [Debian 12, Container]
##

test: testpod-debian testpod-rocky


##
# Test/Dev - Container (packer)
##

debian_hostname ?= testpc1
rocky_hostname ?= testbox1

# Password for test data (based on iso/debconf_early)
.vaultpass:
	gpg --batch --decrypt --passphrase AWeakLink conf/_test/key.gpg >.vaultpass

# Run tests inside container
testpod-%: tpod_% .vaultpass
	podman run -d --replace --name $@ \
		--systemd=always --cap-add=NET_ADMIN,NET_RAW,SYS_ADMIN \
		-h $($*_hostname) \
		-v "$(PWD):/etc/ansible" \
		tpod_$* >/dev/null
	podman exec $@ /etc/ansible/test/Dockertest.sh; \
		rc="$$?"; \
		podman rm -f $@ >/dev/null; \
		exit "$$rc"

# Log in to container (pre-dockertest.sh)
playpod-%: tpod_% .vaultpass
	podman run -d --replace --name $@ \
		--systemd=always --cap-add=NET_ADMIN,NET_RAW,SYS_ADMIN \
		-h $($*_hostname) \
		-v "$(PWD):/etc/ansible" \
		tpod_$* >/dev/null
	-podman exec -it $@ /bin/bash
	podman rm -f $@ >/dev/null


##
# Containers (test pods)
##

# Build a container for testing
tpod_%:
	podman build -t tpod_$* \
		-f test/Dockerfile.$*


##
# Test/Dev - Full VM (virtualbox)
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
full-test: testpc1_debian13 pytest-testpc1-user pytest-testpc1-admin

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
else
	./test/vbox_create \
		-i $(WORKSPACE)/teckhost_$*.iso \
		-n testpc1 -p 4222
endif


##
# Cleanup
##

clean: clean-testpc1 cleanpod-debian cleanpod-rocky
	$(RM) iso/*/testseed.cfg teckhost*.iso
	podman system prune -f || true

# Delete a Container if it exists
cleanpod-%:
	@if [ -n "$(findstring tpod_$*,$(shell podman images))" ]; then \
		podman rmi tpod_$*; \
	else \
		echo "No container exists for $*; skipping"; \
	fi

# Delete a VM if it exists
clean-%:
	@if [ -n "$(findstring $*,$(shell VBoxManage list vms))" ]; then \
		VBoxManage controlvm $* poweroff || true; \
		VBoxManage unregistervm $* --delete; \
	else \
		echo "No VMs could match $*; skipping"; \
	fi


.PHONY: testprep test clean
