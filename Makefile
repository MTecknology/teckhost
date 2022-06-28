#!/usr/bin/make -f
##
# Makefile for Teckhost systems
# See env[TH_SRC] and env[TH_CKSUM] for ISO building
##
export WORKSPACE ?= $(abspath $(PWD)/)
export GRUB_EXTRA ?= hostname=testpc1


##
# ISO
##

# Intended for production use (assumes nvme)
teckhost.iso:
	./iso/build_iso \
	    -s iso/preseed.cfg \
	    -o teckhost.iso \
	    -x "$(GRUB_EXTRA)" \
	    -f iso/grub-bios.cfg -g iso/grub-efi.cfg

# Intended for use with automated testing
teckhost-%.iso: testseed.cfg
	./iso/build_iso \
	    -s testseed.cfg \
	    -o teckhost-$(subst teckhost-,,$(subst .iso,,$@)).iso \
	    -d /dev/$(subst teckhost-,,$(subst .iso,,$@)) \
	    -x "$(GRUB_EXTRA)" \
	    -f iso/grub-bios.cfg -g iso/grub-efi.cfg

# Intended for local developmnt with virtualbox
teckhost-local.iso: testseed.cfg
	./iso/build_iso \
	    -s testseed.cfg \
	    -o teckhost-local.iso \
	    -d /dev/sda \
	    -x "hostname=devpc1 BS_devdir=/srv" \
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

# Run all tests against testpc1
test: testpc1 test-testpc1-user test-testpc1-admin

# Run all tests against devpc1
test-devpc1: devpc1 test-devpc1-user test-devpc1-admin

# Run tests against a host (test-<host>-<type>)
_target = $(word $2,$(subst -, ,$@))
test-%:
	python3 -m pytest \
	    --ssh-config=test/.ssh/config --ssh-identity-file=test/.ssh/id_ed25519 \
	    --hosts=ssh://test$(call _target,$*,3)@$(call _target,$*,2) \
	    --type $(call _target,$*,3)

##
# Dev Stuff
##

# Connect to dev host as user
devpc1-ssh: devpc1
	ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" \
	    -i test/.ssh/id_ed25519 ssh://testuser@localhost:4224

# Connect to dev host as admin
devpc1-root: devpc1
	ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" \
	    -i test/.ssh/id_ed25519 ssh://testadmin@localhost:4224


##
# Virtual Machines
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

clean: clean-testpc1 clean-devcp1
	$(RM) testseed.cfg teckhost*.iso

clean-%:
ifneq (,$(findstring pc,$(shell VBoxManage list vms)))
	VBoxManage controlvm $(subst clean-,,$@) poweroff || true
	VBoxManage unregistervm $(subst clean-,,$@) --delete
else
	@echo 'No VMs could match $(subst clean-,,$@); skipping'
endif


.PHONY: testprep test testpc1 devpc1 devpc1-user devcp1-admin clean
