#!/usr/bin/make -f
##
# Makefile for Teckhost systems
# See env[TH_SRC] and env[TH_CKSUM] for ISO building
#
# See git history before trying to "clean up" anything in this file.
##
export WORKSPACE ?= $(abspath $(PWD)/)
export GRUB_EXTRA ?= hostname=testpc1


##
# ISO
##

# Intended for production use (assumes nvme)
teckhost.iso: iso/preseed.cfg iso/grub-bios.cfg iso/grub-efi.cfg
	./iso/build_iso \
	    -s iso/preseed.cfg \
	    -o teckhost.iso \
	    -x "$(GRUB_EXTRA)" \
	    -f iso/grub-bios.cfg -g iso/grub-efi.cfg

# Intended for use with automated testing
teckhost-%.iso: testseed.cfg iso/grub-bios.cfg iso/grub-efi.cfg
	./iso/build_iso \
	    -s testseed.cfg \
	    -o teckhost-$(subst teckhost-,,$(subst .iso,,$@)).iso \
	    -d /dev/$(subst teckhost-,,$(subst .iso,,$@)) \
	    -x "$(GRUB_EXTRA)" \
	    -f iso/grub-bios.cfg -g iso/grub-efi.cfg

# Intended for local developmnt with virtualbox
teckhost-local.iso: testseed.cfg iso/grub-bios.cfg iso/grub-efi.cfg
	./iso/build_iso \
	    -s testseed.cfg \
	    -o teckhost-local.iso \
	    -d /dev/sda \
	    -x "hostname=devpc1 BS_devdir=/srv" \
	    -f iso/grub-bios.cfg -g iso/grub-efi.cfg

##
# Preeseed
##

testseed.cfg: iso/preseed.cfg test/preseed.patch
	cp iso/preseed.cfg testseed.cfg
	patch testseed.cfg test/preseed.patch


##
# Test/Dev Stuff
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
test-%: testprep
	python3 -m pytest \
	    --ssh-config=test/.ssh/config --ssh-identity-file=test/.ssh/id_ed25519 \
	    --hosts=ssh://test$(call _target,$*,3)@$(call _target,$*,2) \
	    --type $(call _target,$*,3)

# Connect to a host using ssh (ssh-<host>-<user>)
ssh-%:
	ssh \
	    -F test/.ssh/config -i test/.ssh/id_ed25519 \
	    ssh://test$(call _target,$*,3)@$(call _target,$*,2)

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

clean: clean-testpc1 clean-devpc1
	$(RM) testseed.cfg teckhost*.iso

# Delete testpc1 if it exists
clean-testpc1:
ifneq (,$(findstring testpc1,$(shell VBoxManage list vms)))
	VBoxManage controlvm testpc1 poweroff || true
	VBoxManage unregistervm testpc1 --delete
else
	@echo 'No VMs could match testpc1; skipping'
endif

# Delete testpc1 if it exists
clean-devpc1:
ifneq (,$(findstring devpc1,$(shell VBoxManage list vms)))
	VBoxManage controlvm devpc1 poweroff || true
	VBoxManage unregistervm devpc1 --delete
else
	@echo 'No VMs could match devpc1; skipping'
endif


.PHONY: testprep test testpc1 devpc1 clean
