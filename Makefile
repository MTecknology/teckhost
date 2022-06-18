##
# Makefile for Teckhost systems
#
# NOTE: See env[TH_SRC] and env[TH_CKSUM] for ISO building
##
export WORKSPACE ?= $(abspath $(PWD)/)


.PHONY: clean
clean:
	$(RM) testseed.cfg teckhost.iso teckhost-sda.iso
ifneq (,$(findstring testpc1,$(shell VBoxManage list vms)))
	VBoxManage controlvm testpc1 poweroff
	VBoxManage unregistervm testpc1 --delete
endif


testseed.cfg:
	cp iso/preseed.cfg testseed.cfg
	patch testseed.cfg test/preseed.patch


teckhost.iso:
	./iso/build_iso -s iso/preseed.cfg -o teckhost.iso \
		-f iso/grub-bios.cfg -g iso/grub-efi.cfg
	echo $(WORKSPACE)


teckhost-sda.iso: testseed.cfg
	./iso/build_iso -s testseed.cfg -o teckhost-sda.iso -d /dev/sda \
		-f iso/grub-bios.cfg -g iso/grub-efi.cfg


.PHONY: testpc1
testpc1: teckhost-sda.iso
ifneq (,$(findstring testpc1,$(shell VBoxManage list runningvms)))
	echo 'VM already exists: testpc1'
else
	./test/vbox_create -i $(WORKSPACE)/teckhost-sda.iso
endif

.PHONY: testprep
testprep:
	chmod 700 test/.ssh
	chmod 600 test/.ssh/id_ed25519

.PHONY: test-user
test-user: testpc1 testprep
	python3 -m pytest \
	    --ssh-config=test/.ssh/config --ssh-identity-file=test/.ssh/id_ed25519 \
	    --hosts=ssh://tester@testpc1 --type user

.PHONY: test-admin
test-admin: testpc1 testprep
	python3 -m pytest \
	    --ssh-config=test/.ssh/config --ssh-identity-file=test/.ssh/id_ed25519 \
	    --hosts=ssh://testadmin@testpc1 --type admin

.PHONY: test
test: test-user test-admin
