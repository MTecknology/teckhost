#!/usr/bin/env python3
'''
Source: CIS_Distribution_Independent_Linux_Benchmark_v2.0.0.pdf
Implements: 1.4 Secure Boot Settings
'''
import pytest
import stat
from conftest import SUDO_WRAPPER


class TestBoot:

    @pytest.mark.breaks_oci
    def test_bootloader_permissions(self, host):
        '''1.4.1 Ensure permissions on bootloader config are configured'''
        probe = host.file('/boot/grub/grub.cfg')
        assert probe.is_file, 'grub.cfg was not found'
        assert probe.uid == 0, 'grub.cfg not owned by user:root'
        assert probe.gid == 0, 'grub.cfg not owned by group:root'
        assert probe.mode != stat.S_IWOTH, 'file is world-writeable'

    @pytest.mark.admin
    @pytest.mark.breaks_oci
    def test_bootloader_password(self, host):
        '''1.4.2 Ensure bootloader password is set'''
        probe = host.run(f'{SUDO_WRAPPER} cat /boot/grub/grub.cfg')
        assert probe.rc == 0, 'unexpected exit status'
        stdout = probe.stdout.strip()
        assert 'set superusers=' in stdout
        assert 'password_pbkdf2' in stdout

    @pytest.mark.admin
    def test_bootloader_singleauth(self, host):
        '''1.4.3 Ensure authentication required for single user mode'''
        probe = host.run(f'{SUDO_WRAPPER} grep "^root:[*!]:" /etc/shadow')
        assert probe.rc == 1, 'no password is set for root user'
        stdout = probe.stdout.strip()
        assert stdout == ''
