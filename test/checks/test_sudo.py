#!/usr/bin/env python3
##
# Validation Tests: Sudo
##
import pytest


@pytest.mark.breaks_oci
class TestSudoForAll:

    def test_sudo_approved_commands(self, host):
        '''Expect all users to be able to use whitelisted commands WITHOUT password'''
        assert not host.mount_point('/mnt').exists
        assert host.run('sudo /bin/mount -t tmpfs none /mnt').rc == 0
        assert host.mount_point('/mnt').exists
        assert host.run('sudo /bin/umount /mnt').rc == 0
        assert not host.mount_point('/mnt').exists


@pytest.mark.admin
@pytest.mark.breaks_oci
class TestSudoForAdmins:

    def test_sudo_admin_withpass_success(self, host):
        '''Expect success from a sudo-capable (admin) user WITH password'''
        assert host.check_output('echo SuperInsecurePassword4Testing | sudo -S whoami') == 'root'
        assert host.run('echo SuperInsecurePassword4Testing | sudo -S whoami').rc == 0

    def test_sudo_admin_nopass_error(self, host):
        '''Expect error from a sudo-capable (admin) user WITHOUT password'''
        assert host.run('sudo whoami').rc != 0


@pytest.mark.user
@pytest.mark.breaks_oci
class TestSudoForUsers:

    def test_sudo_user_nopass_error(self, host):
        '''Expect an error from a non-sudo user running unapproved commands WITHOUT password'''
        assert host.run('sudo whoami').rc != 0

    def test_sudo_user_withpass_error(self, host):
        '''Expect an error from a non-sudo user running unapproved commands WITH password'''
        assert host.run('echo SuperInsecurePassword4Testing | sudo -S whoami').rc != 0
