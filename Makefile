#!/usr/bin/make -f
##
# Makefile for Teckhost systems
# See env[TH_SRC] and env[TH_CKSUM] for ISO building
##
export WORKSPACE ?= $(abspath $(PWD)/)


##
# ISO
##

# Intended for production use
teckhost.iso:
	./iso/build_iso -s iso/preseed.cfg -o teckhost.iso \
		-f iso/grub-bios.cfg -g iso/grub-efi.cfg

# Intended for testing with virtualbox
teckhost-sda.iso: testseed.cfg
	./iso/build_iso -s testseed.cfg -o teckhost-sda.iso \
	    -d /dev/sda -x "hostname=testpc1" \
	    -f iso/grub-bios.cfg -g iso/grub-efi.cfg

# Intended for local developmnt
teckhost-local.iso: testseed.cfg
	./iso/build_iso -s testseed.cfg -o teckhost-local.iso \
	    -d /dev/sda -x "hostname=devpc1 BS_devdir=/srv" \
	    -f iso/grub-bios.cfg -g iso/grub-efi.cfg

##
# Preeseed
##

testseed.cfg:
	cp iso/preseed.cfg testseed.cfg
	patch testseed.cfg test/preseed.patch


##
# Test Stuff
##

# This can't be cleanly checked into git
testprep:
	chmod 0700 test/.ssh
	chmod 0600 test/.ssh/id_ed25519

# Run all tests
test: test-user test-admin

# Rut pytest for user-targeted tests
test-user: testpc1 testprep
	python3 -m pytest \
	    --ssh-config=test/.ssh/config --ssh-identity-file=test/.ssh/id_ed25519 \
	    --hosts=ssh://tester@testpc1 --type user

# Rut pytest for admin-targeted tests
test-admin: testpc1 testprep
	python3 -m pytest \
	    --ssh-config=test/.ssh/config --ssh-identity-file=test/.ssh/id_ed25519 \
	    --hosts=ssh://testadmin@testpc1 --type admin


##
# Dev Stuff
##

# Connect to dev host as user
devpc1-ssh: devpc1
	ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" \
	    -i test/.ssh/id_ed25519 ssh://tester@localhost:4224

# Connect to dev host as admin
devpc1-root: devpc1
	ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" \
	    -i test/.ssh/id_ed25519 ssh://testadmin@localhost:4224

# Run tests on dev box
devpc1-test: devpc1
	python3 -m pytest \
	    --ssh-config=test/.ssh/config --ssh-identity-file=test/.ssh/id_ed25519 \
	    --hosts=ssh://tester@devpc1 --type user
	python3 -m pytest \
	    --ssh-config=test/.ssh/config --ssh-identity-file=test/.ssh/id_ed25519 \
	    --hosts=ssh://testadmin@devpc1 --type admin


##
# Test Boxes
##

# TEST: The standard virtualbox deployment; replicates production
testpc1: teckhost-sda.iso
ifneq (,$(findstring testpc1,$(shell VBoxManage list runningvms)))
	echo 'VM already exists: testpc1'
else
	./test/vbox_create -i $(WORKSPACE)/teckhost-sda.iso -n testpc1 \
	    -p 4222
endif

# DEV: Build a dev box using local file directory for salt data
#      Note: The first highstate will still be from git
devpc1: teckhost-local.iso
ifneq (,$(findstring devpc1,$(shell VBoxManage list runningvms)))
	echo 'VM already exists: devpc1'
else
	./test/vbox_create -i $(WORKSPACE)/teckhost-local.iso -n devpc1 \
	    -p 4224 -d $(WORKSPACE)
endif


##
# Cleanup
##

clean:
	$(RM) testseed.cfg teckhost*.iso
ifneq (,$(findstring testpc1,$(shell VBoxManage list vms)))
	VBoxManage controlvm testpc1 poweroff || true
	VBoxManage unregistervm testpc1 --delete
endif
ifneq (,$(findstring devpc1,$(shell VBoxManage list vms)))
	VBoxManage controlvm devpc1 poweroff || true
	VBoxManage unregistervm devpc1 --delete
endif


.PHONY: test-admin test-user test testprep testpc1 devpc1 devpc1-ssh devcp1-root clean
