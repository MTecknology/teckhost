#!/usr/bin/env python3
'''
Source: CIS_Distribution_Independent_Linux_Benchmark_v2.0.0.pdf
Implements: 6.2 User and Group Settings
Not-Implemented:
- 6.2.6 Ensure root PATH Integrity - requires execution as root
'''
import pytest
from conftest import SUDO_WRAPPER


class TestUsers:

    @pytest.mark.admin
    def test_empty_passwords(self, host):
        '''6.2.1 Ensure password fields are not empty'''
        probe = host.run(f'{SUDO_WRAPPER} grep "^[^:]+::" /etc/shadow')
        assert probe.rc == 1, 'unexpected exit status from grep'
        stdout = probe.stdout.strip()
        assert stdout == ''

    @pytest.mark.parametrize(
        'pwfile', [
            'passwd',   # 6.2.2
            'shadow',   # 6.2.3
            'group',    # 6.2.4
        ])
    @pytest.mark.admin
    def test_legacy_pwfile(self, host, pwfile):
        '''6.2.[2-4] Ensure no legacy "+" entries exist in /etc/[*]'''
        probe = host.run(f'{SUDO_WRAPPER} grep "^+:" /etc/{pwfile}')
        assert probe.rc == 1, 'unexpected exit status from grep'
        stdout = probe.stdout.strip()
        assert stdout == ''

    def test_uid0_root(self, host):
        '''6.2.5 Ensure root is the only UID 0 account'''
        probe = host.run('grep -E "^([^:]*:){2}0:" /etc/passwd | cut -d: -f1')
        assert probe.rc == 0, 'unexpected exit status from cut'
        stdout = probe.stdout.strip()
        assert stdout == 'root'

    @pytest.mark.admin
    def test_user_files(self, host):
        '''6.2.[7-14] Ensure users do (not) have [user-owned files]'''
        for username in host.check_output("awk -F: '$3 >= 1000 { print $1 }' /etc/passwd").split('\n'):
            if username in ['nobody']:
                continue
            userprobe = host.user(username)
            userdir = host.file(userprobe.home)
            assert userdir.is_directory  # 6.2.7
            assert userdir.user == username  # 6.2.9
            assert userdir.group == username
            assert oct(userdir.mode) in ['0o700', '0o750']  # 6.2.[8,10]
            assert host.run(f'{SUDO_WRAPPER} stat {userprobe.home}/.forward').rc != 0, \
                'file-found: {userprobe.home}/.forward'  # 6.2.11
            assert host.run(f'{SUDO_WRAPPER} stat {userprobe.home}/.forward').rc != 0, \
                'file-found: {userprobe.home}/.netrc'  # 6.2.[12-13]
            assert host.run(f'{SUDO_WRAPPER} stat {userprobe.home}/.forward').rc != 0, \
                'file-found: {userprobe.home}/.rhosts'  # 6.2.14

    def test_duplicate_groups(self, host):
        '''6.2.15 Ensure all groups in /etc/passwd exist in /etc/group'''
        passwd_gids = set(group.split(':')[3] for group in host.file('/etc/passwd').content_string.splitlines())
        group_gids = set(group.split(':')[2] for group in host.file('/etc/group').content_string.splitlines())
        assert passwd_gids.issubset(group_gids)

    @pytest.mark.parametrize(
        'pwfile,column', [
            ('passwd', '3'),    # 6.2.16
            ('group', '3'),     # 6.2.17
            ('passwd', '1'),    # 6.2.18
            ('group', '1'),     # 6.2.19
        ])
    def test_duplicate_ids(self, host, pwfile, column):
        '''6.2.[16-19] Ensure no duplicate [IDs] exist'''
        probe = host.run('cut -d: -f{column} /etc/{pwfile} | sort -n | uniq -d')
        assert probe.rc == 0
        assert probe.stdout.strip() == ''

    def test_empty_shadow_group(self, host):
        '''6.2.20 Ensure shadow group is empty'''
        probe = host.run('grep shadow /etc/group')
        assert probe.stdout.strip() == 'shadow:x:42:'
