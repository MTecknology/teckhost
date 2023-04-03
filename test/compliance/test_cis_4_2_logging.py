#!/usr/bin/env python3
'''
Source: CIS_Distribution_Independent_Linux_Benchmark_v2.0.0.pdf
Implements: [4.2 Configure Logging,  4.3 Ensure logrotate is configured]
'''
import pytest
import stat


class TestLogging:

    def test_rsyslog_enabled(self, host):
        '''4.2.1.1 Ensure rsyslog is installed'''
        assert host.package('rsyslog').is_installed
        # 4.2.1.2 Ensure rsyslog Service is enabled
        assert host.service('rsyslog').is_running

    @pytest.mark.parametrize(
        'checkopt', [
            # 4.2.1.3
            'var/log/mail.log',
            'var/log/cron.log',
            'var/log/kern.log',
            'var/log/auth.log',
            'var/log/syslog',
            # 4.2.1.4
            '\n$FileCreateMode 0640',
            # 4.2.1.5 - remote syslog not practical on personal device
        ])
    def test_rsyslog_config(self, host, checkopt):
        '''4.2.1.X Ensure logging is configured'''
        probe = host.file('/etc/rsyslog.conf')
        assert checkopt in probe.content_string

    def test_rsyslog_notserver(self, host):
        '''4.2.1.6 Ensure remote rsyslog messages are only accepted on [servers]'''
        probe = host.file('/etc/rsyslog.conf')
        assert '\n$ModLoad imtcp' not in probe.content_string
        assert '\n$InputTCPServerRun 514' not in probe.content_string

    @pytest.mark.parametrize(
        'checkopt', [
            'ForwardToSyslog=yes',     # 4.2.2.1
            'Compress=yes',            # 4.2.2.2
            'Storage=persistent',      # 4.2.2.3
        ])
    def test_journald_forward(self, host, checkopt):
        '''4.2.2.1 Ensure journald is configured to send logs to rsyslog'''
        probe = host.file('/etc/systemd/journald.conf')
        assert probe.is_file
        config = probe.content_string
        assert f'\n{checkopt}' in config

    def test_logfile_permissions(self, host):
        '''4.2.3 Ensure permissions on all logfiles are configured'''
        for path in host.file('/var/log').listdir():
            probe = host.file(f'/var/log/{path}')
            assert probe.user in [
                'root',
                'Debian-exim',
                '_chrony',
                'speech-dispatcher',
            ]
            assert probe.group in [
                'root',
                'adm',
                'utmp',
                'systemd-journal',
                '_chrony',
            ]
            assert probe.mode != stat.S_IWOTH, 'log file is world-writeable'

    def test_logrotate_enabled(self, host):
        '''4.3 Ensure logrotate is configured'''
        assert host.package('logrotate').is_installed
        probe = host.run('grep -q logrotate -R /etc/cron*')
        assert probe.rc == 0, 'logrotate not found in cron'
        stdout = probe.stdout.strip()
        assert stdout == ''
