#!/usr/bin/env python3
'''
Source: CIS_Distribution_Independent_Linux_Benchmark_v2.0.0.pdf
Implements: 6.1 System File Permissions
'''
import pytest


class TestIntegrity:

    @pytest.mark.breaks_oci
    @pytest.mark.parametrize(
        # packages which should have no modificatons
        'pkgname', [
            'accountsservice', 'acl', 'adduser', 'anacron', 'apparmor',
            'apparmor-utils', 'apt', 'apt-utils', 'base-files', 'bash',
            'bind9-host', 'binutils', 'binutils-common', 'busybox',
            'ca-certificates', 'console-setup', 'coreutils', 'cpio',
            'cracklib-runtime', 'cron', 'dpkg', 'gcc', 'gpg', 'init',
            'lightdm', 'linux-base', 'net-tools', 'nftables', 'openssl',
            'perl-base', 'xauth',
        ])
    def test_package_integrity(self, host, pkgname):
        '''6.1.1 Audit system file permissions'''
        probe = host.run(f'dpkg --verify {pkgname}')
        assert probe.rc == 0, f'unexpected changes to {pkgname}'
        assert probe.stdout.strip() == ''

    @pytest.mark.parametrize(
        # packages which should have no modificatons
        'authfile,filemode', [
            ('passwd', '0o644'),    # 6.1.2
            ('shadow', '0o640'),    # 6.1.3
            ('group', '0o644'),     # 6.1.4
            ('gshadow', '0o640'),   # 6.1.5
            ('passwd-', '0o644'),   # 6.1.6
            ('shadow-', '0o640'),   # 6.1.7
            ('group-', '0o644'),    # 6.1.8
            ('gshadow-', '0o640'),  # 6.1.9
        ])
    def test_authfile_permissions(self, host, authfile, filemode):
        '''6.1.2 Ensure permissions on /etc/[*] are configured'''
        probe = host.file(f'/etc/{authfile}')
        assert probe.user == 'root'
        assert probe.group in ['root', 'shadow']
        assert oct(probe.mode) == filemode

    @pytest.mark.breaks_oci
    def test_world_writeable(self, host):
        '''6.1.10 Ensure no world writable files exist'''
        probe = host.run("df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -0002")
        assert probe.stdout.strip() == ''

    def test_unowned_files(self, host):
        '''6.1.11 Ensure no unowned files or directories exist'''
        probe = host.run("df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser")
        assert probe.stdout.strip() == ''

    def test_ungrouped_files(self, host):
        '''6.1.12 Ensure no ungrouped files or directories exist'''
        probe = host.run("df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -nogroup")
        assert probe.stdout.strip() == ''
