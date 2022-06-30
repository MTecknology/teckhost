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
	    -o "$@" \
	    -d "/dev/$*" \
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
test: test-testpc1 
test-testpc1: pytest-testpc1-user pytest-testpc1-admin

# Run all tests against devpc1
test-devpc1: pytest-devpc1-user pytest-devpc1-admin

# Run tests against a host (test-<host>-<type>)
_target = $(word $2,$(subst -, ,$1))

.SECONDEXPANSION:
pytest-%: testprep $$(call _target,$$*,1) explicit_phony
	python3 -m pytest \
	    --ssh-config=test/.ssh/config --ssh-identity-file=test/.ssh/id_ed25519 \
	    --hosts=ssh://test$(call _target,$*,2)@$(call _target,$*,1) \
	    --type $(call _target,$*,2)

# Connect to a host using ssh (ssh-<host>-<user>)
ssh-%: $$(call _target,$$*,1) explicit_phony
	ssh \
	    -F test/.ssh/config -i test/.ssh/id_ed25519 \
	    ssh://test$(call _target,$*,2)@$(call _target,$*,1)

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

# Delete a VM if it exists
clean-%: explicit_phony
	@if [ -n "$(findstring $*,$(shell VBoxManage list vms))" ]; then \
		VBoxManage controlvm $* poweroff || true; \
		VBoxManage unregistervm $* --delete; \
	else \
		echo "No VMs could match $*; skipping"; \
	fi


explicit_phony:
.PHONY: testprep test testpc1 devpc1 clean explicit_phony
