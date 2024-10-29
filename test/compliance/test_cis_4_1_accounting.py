#!/usr/bin/env python3
'''
Source: CIS_Distribution_Independent_Linux_Benchmark_v2.0.0.pdf
Implements: 4.1 Configure System Accounting (auditd)
'''
import pytest
from conftest import SUDO_WRAPPER


@pytest.mark.admin
@pytest.mark.breaks_oci
class TestAccounting:

    @pytest.mark.parametrize(
        'setting', [
            'max_log_file',             # 4.1.1.1
            'admin_space_left_action',  # 4.1.1.2 - default of SUSPEND is sufficient
            'max_log_file_action',      # 4.1.1.3 - 'keep_logs' inhibits hands-off management
        ])
    def test_auditd_setting_present(self, host, setting):
        '''4.1(.X) Configure System Accounting (auditd)'''
        probe = host.run(f'{SUDO_WRAPPER} cat /etc/audit/auditd.conf')
        assert probe.rc == 0, 'unexpected exit status'
        auditdconf = probe.stdout.strip()
        assert f'\n{setting} = ' in auditdconf, f'{setting} not configured in auditd.conf'

    def test_auditd_present(self, host):
        '''4.1.2 Ensure auditd is installed'''
        assert host.package('auditd').is_installed
        # 4.1.3 Ensure auditd service is enabled
        assert host.service('auditd').is_running

    def test_auditd_kernel(self, host):
        '''4.1.4 Ensure auditing for processes that start prior to auditd is enabled'''
        probe = host.run(f'{SUDO_WRAPPER} grep "^\\s*linux" /boot/grub/grub.cfg | grep -Ev "single|audit=1"')
        assert probe.rc != 0, 'kernel lines found without audit=1'
        stdout = probe.stdout.strip()
        assert stdout == ''

    @pytest.mark.parametrize(
        # Expected configuration lines
        'param', [
            # 4.1.5
            '-S adjtimex',
            '-S settimeofday',
            '-k time-change',
            '-S clock_settime',
            '-w /etc/localtime',
            # 4.1.6
            '-w /etc/group',
            '-w /etc/passwd',
            '-w /etc/gshadow',
            '-w /etc/shadow',
            '-w /etc/security/opasswd',
            # 4.1.7
            '-S sethostname',
            '-S setdomainname',
            '-k system-locale',
            '-w /etc/issue',
            '-w /etc/issue.net',
            '-w /etc/hosts',
            # 4.1.8
            '-w /etc/apparmor',
            '-w /etc/apparmor.d',
            '-k MAC-policy',
            # 4.1.9
            '-w /var/log/faillog',
            '-w /var/log/lastlog',
            '-w /var/log/tallylog',
            # 4.1.10
            '-w /var/run/utmp -p wa -k session',
            '-w /var/log/wtmp -p wa -k logins',
            '-w /var/log/btmp -p wa -k logins',
            # 4.1.11
            '-S chmod -S fchmod -S fchmodat -F auid>=500 -F auid!=',
            '-k perm_mod',
            '-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=500 -F auid!=',
            # 4.1.12
            '-S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=500 -F auid!=',
            '-k access',
            '-S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=500 -F auid!=',
            # 4.1.14
            '-S mount',
            '-S umount',
            '-S umount2',
            '-k mount',
            # 4.1.15
            # '-S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=',
            # '-k delete',
            # 4.1.16
            '-w /etc/sudoers',
            # 4.1.17
            '-w /var/log/auth.log -p wa -k actions',
            # 4.1.18
            '-w /sbin/insmod -p x -k modules',
            '-w /sbin/rmmod -p x -k modules',
            '-w /sbin/modprobe -p x -k modules',
            '-a always,exit -F arch=b64 -S init_module -S delete_module -k modules',
            # 4.1.19
            '-e 2',
        ])
    def test_auditctl_config(self, host, param):
        '''4.1.[5-19] Ensure events that <param> [is configured]'''
        # Note: This file is auto-generated when the service starts
        probe = host.run(f'{SUDO_WRAPPER} cat /etc/audit/audit.rules')
        assert probe.rc == 0, 'unable to get auditctl configuration'
        stdout = probe.stdout.strip()
        assert param in stdout

    @pytest.mark.parametrize(
        # Search terms that indicate successful loading of rules
        'needle', [
            # 4.1.5
            'adjtimex',
            'settimeofday',
            'clock_settime',
            '-k time-change',
            '-w /etc/localtime',
            # 4.1.6
            '-w /etc/group',
            '-w /etc/passwd',
            '-w /etc/gshadow',
            '-w /etc/shadow',
            '-w /etc/security/opasswd',
            # 4.1.7
            'sethostname',
            'setdomainname',
            'system-locale',
            '-w /etc/issue',
            '-w /etc/issue.net',
            '-w /etc/hosts',
            # 4.1.8
            '-w /etc/apparmor',
            '-w /etc/apparmor.d',
            '-k MAC-policy',
            # 4.1.9
            '-w /var/log/faillog',
            '-w /var/log/lastlog',
            '-w /var/log/tallylog',
            # 4.1.10
            '-w /var/run/utmp',
            '-w /var/log/wtmp',
            '-w /var/log/btmp',
            # 4.1.11
            '-F auid>=500',
            'perm_mod',
            # 4.1.12
            '-F exit=-EACCES -F auid>=500 -F',
            'access',
            '-F exit=-EPERM -F auid>=500 -F',
            # 4.1.14
            'umount',
            'umount2',
            # 4.1.15
            # 'delete',
            # 4.1.16
            '-w /etc/sudoers',
            # 4.1.17
            '-w /var/log/auth.log',
            # 4.1.18
            '-w /sbin/insmod',
            '-w /sbin/rmmod',
            '-w /sbin/modprobe',
            'modules',
        ])
    def test_auditctl_runtime(self, host, needle):
        '''4.1.[5-19] [Verify configuration was loaded]'''
        probe = host.run(f'{SUDO_WRAPPER} auditctl -l')
        assert probe.rc == 0, 'unable to get auditctl runtime parameters'
        stdout = probe.stdout.strip()
        assert stdout != 'No rules'
        assert needle in stdout
