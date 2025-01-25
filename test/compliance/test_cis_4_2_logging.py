#!/usr/bin/env python3
'''
Source: CIS_Distribution_Independent_Linux_Benchmark_v2.0.0.pdf
Implements: [4.2 Configure Logging,  4.3 Ensure logrotate is configured]
Deprecated: rsyslog replaced with journald
'''
import stat


class TestLogging:

    def test_rsyslog_enabled(self, host, pytestconfig):
        '''4.2.1.1 Ensure rsyslog is installed'''
        assert host.file('/usr/bin/journalctl').exists

        if pytestconfig.getoption('--type') != 'container':
            # 4.2.1.2 Ensure rsyslog Service is enabled
            assert host.file('/lib/systemd/systemd-journald').exists

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
