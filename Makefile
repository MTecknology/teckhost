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
debian12_src   ?= https://cdimage.debian.org/cdimage/archive/12.8.0/amd64/iso-cd/debian-12.8.0-amd64-netinst.iso
debian12_sha   ?= 04396d12b0f377958a070c38a923c227832fa3b3e18ddc013936ecf492e9fbb3
ubuntu2204_src ?= https://releases.ubuntu.com/20.04.6/ubuntu-20.04.6-desktop-amd64.iso
ubuntu2204_sha ?= 510ce77afcb9537f198bc7daa0e5b503b6e67aaed68146943c231baeaab94df1

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


##
# Default Test [Debian 12, Container]
##

test: testpod-debian


##
# Test/Dev - Container (packer)
##

# Run tests inside container
testpod-%: tpod_%
	podman run --rm -it --cap-add=NET_ADMIN,NET_RAW \
		-h testpc1 \
		-v "$(PWD):/etc/ansible" \
		-e "BS_GITREV=$(BS_GITREV)" \
		tpod_$* /etc/ansible/test/Dockertest.sh

# Log in to container (pre-dockertest.sh)
playpod-%: tpod_%
	podman run --rm -it --cap-add=NET_ADMIN,NET_RAW \
		-h testpc1 \
		-v "$(PWD):/etc/ansible" \
		tpod_$* /bin/bash


##
# Containers (test pods)
##

# Build a container for testing
# Dockerfile pre-installs many desktop files and requires 8+GB in /var/tmp.
tpod_%:
	@current_size=$$(df -m /var/tmp | awk 'NR==2 {print $$2}'); \
	if [ "$$current_size" -lt 10240 ]; then \
		echo 'WARN: podman test requires 10GB in /var/tmp'; \
		mount -o remount,size=10G /var/tmp; \
	fi
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
full-test: testpc1_debian12 pytest-testpc1-user pytest-testpc1-admin

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

clean: clean-testpc1 cleanpod-debian
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
