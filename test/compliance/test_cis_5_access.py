#!/usr/bin/env python3
'''
Source: CIS_Distribution_Independent_Linux_Benchmark_v2.0.0.pdf
Implements: 5 Access, Authentication and Authorization
Not-Implemented:
- 5.1.8 Ensure at/cron is restricted to authorized users - common use
- 5.3 Configure PAM - local security policy is enforced via salt
- 5.4.1.X Ensure [password requirement] - user credentials/expiration managed via salt
- 5.4.5 Ensure default user shell timeout is 900 seconds or less - not practical
'''
import pytest
import stat
from conftest import SUDO_WRAPPER


class TestAccess:

    def test_cron_enabled(self, host):
        '''5.1.1 Ensure cron daemon is enabled'''
        assert host.package('cron').is_installed
        assert host.service('cron').is_running

    @pytest.mark.parametrize(
        'cronfile', [
            'crontab',          # 5.1.2
            'cron.hourly',      # 5.1.3
            'cron.daily',       # 5.1.4
            'cron.weekly',      # 5.1.5
            'cron.monthly',     # 5.1.6
            'cron.d',           # 5.1.7
        ])
    def test_cron_files(self, host, cronfile):
        '''5.1.[2-7] Ensure permissions on /etc/[cron*] are configured'''
        probe = host.file(f'/etc/{cronfile}')
        assert probe.user == 'root'
        assert probe.group == 'root'
        assert probe.mode != stat.S_IWOTH, 'cron file is world-writeable'

    def test_sshd_config(self, host):
        '''5.2.1 Ensure permissions on /etc/ssh/sshd_config are configured '''
        if not host.package('openssh-server').is_installed:
            pytest.skip('SSH Server Not Found')
        probe = host.file('/etc/ssh/sshd_config')
        assert probe.user == 'root'
        assert probe.group == 'root'
        assert probe.mode != stat.S_IWOTH, 'file is world-writeable'

    def test_sshd_certificates(self, host):
        '''5.2.[2-3] Ensure permissions on SSH [*] host key files are configured'''
        if not host.package('openssh-server').is_installed:
            pytest.skip('SSH Server Not Found')
        for path in host.file('/etc/ssh').listdir():
            if not path.endswith('_key.pub'):
                continue
            probe = host.file(f'/etc/ssh/{path}')
            assert probe.user == 'root'
            assert probe.group == 'root'
            assert probe.mode != stat.S_IWOTH, 'file is world-writeable'
            fileprobe = host.file(f'/etc/ssh/{path.replace(".pub", "")}')
            assert fileprobe.mode != stat.S_IWOTH, 'file is world-writeable'
            assert fileprobe.mode != stat.S_IROTH, 'file is world-readable'
            assert fileprobe.mode != stat.S_IXOTH, 'file is world-executable'

    @pytest.mark.parametrize(
        'argument,expected', [
            # ('protocol', '2'),                  # 5.2.4 - obsolete
            ('loglevel', 'INFO'),               # 5.2.5
            # ('x11forwarding', 'no'),            # 5.2.6 - prefer default
            # ('maxauthtries', '3'),              # 5.2.7 - prefer default
            ('ignorerhosts', 'yes'),            # 5.2.8
            ('hostbasedauthentication', 'no'),  # 5.2.9
            ('permitrootlogin', 'no'),          # 5.2.10
            ('permitemptypasswords', 'no'),     # 5.2.11
            ('permituserenvironment', 'no'),    # 5.2.12
            ('ciphers',                         # 5.2.13
             'chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com'),
            ('macs',                            # 5.2.14
             'umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1'),
            # ('kexalgorithms',                   # 5.2.15
            # 'curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group14-sha256'),
            # ('clientaliveinterval', '300'),     # 5.2.16 - TODO
            ('clientalivecountmax', '3'),       # 5.2.16
            # ('logingracetime', '60'),           # 5.2.16 - TODO
            ('permituserenvironment', 'no'),    # 5.2.17
            ('allowgroups', 'ssh-user'),        # 5.2.18
            # ('banner', '/etc/issue.net') ,      # 5.2.19 - TODO
            ('usepam', 'yes'),                  # 5.2.20
            # ('allowtcpforwarding', 'no') ,      # 5.2.21 - TODO
            # ('maxstartups', '10:30:60') ,       # 5.2.22 - TODO
            # ('maxsessions', '4') ,              # 5.2.23 - TODO
        ])
    @pytest.mark.admin
    def test_sshd_settings(self, host, argument, expected):
        '''5.2.[4-12] Ensure SSH <argument> is <expected> configuration'''
        if not host.package('openssh-server').is_installed:
            pytest.skip('SSH Server Not Found')
        probe = host.run(f'{SUDO_WRAPPER} sshd -T')
        assert probe.rc == 0, 'unable to get sshd runtime parameters'
        sshdconfig = {}
        for line in probe.stdout.strip().split('\n'):
            key, value = line.strip().split(' ', 1)
            sshdconfig[key] = value
        assert sshdconfig[argument] == expected

    def test_root_group(self, host):
        '''5.4.3 Ensure default group for the root account is GID 0'''
        probe = host.run('grep "^root:" /etc/passwd')
        assert probe.rc == 0, 'unable to get sshd runtime parameters'
        stdout = probe.stdout.strip()
        assert stdout == 'root:x:0:0:root:/root:/bin/bash'

    @pytest.mark.skip(reason='TODO')
    def test_default_umask(self, host):
        '''5.4.4 Ensure default user umask is 027 or more restrictive'''
        assert 'umask 027' in host.file('/etc/bash.bashrc').content_string, \
            'umask not set in /etc/bash.bashrc'
        assert 'umask 027' in host.file('/etc/profile').content_string, \
            'umask not set in /etc/profile'

    @pytest.mark.skip(reason='TODO')
    def test_restricted_su(self, host):
        '''5.6 Ensure access to the su command is restricted'''
        pass
