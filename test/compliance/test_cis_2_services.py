#!/usr/bin/env python3
'''
Source: CIS_Distribution_Independent_Linux_Benchmark_v2.0.0.pdf
Implements: 2 Services
'''
import pytest


class TestServices:

    def test_inetd_missing(self, host):
        '''2.1(.X) inetd Services'''
        assert not host.file('/etc/inetd.conf').exists
        assert not host.file('/etc/inetd.d').exists
        assert not host.file('/etc/xinetd.conf').exists
        assert not host.file('/etc/xinetd.d').exists

    def test_ntp_running(self, host, pytestconfig):
        '''2.2.1(.X) Time Synchronization'''
        assert host.package('chrony').is_installed

        if pytestconfig.getoption('--type') != 'container':
            assert host.service('chrony').is_running

    @pytest.mark.breaks_oci
    @pytest.mark.parametrize(
        'service', [
            'systemd-timesyncd',    # 2.2.1.X
            # 'avahi-daemon',         # 2.2.3
            # 'cups',                 # 2.2.4 - common use
            'dhcpd',                # 2.2.5
            'slapd',                # 2.2.6
            'nfs', 'rpcbind',       # 2.2.7
            'named',                # 2.2.8
            'vsftpd',               # 2.2.9
            'httpd',                # 2.2.10
            'dovecot',              # 2.2.11
            'smb',                  # 2.2.12
            'squid',                # 2.2.13
            'snmpd',                # 2.2.14
            'rsyncd',               # 2.2.16
            'ypserv',               # 2.2.17
            'ypbind',               # 2.3.1
            'rsh',                  # 2.3.2
            'talk',                 # 2.3.3
            'telnet',               # 2.3.4
            'openldap-clients',     # 2.3.5
        ])
    def test_service_missing(self, host, service):
        '''2.[2-3].X Ensure <service> is not enabled'''
        assert not host.package(service).is_installed
        assert not host.service(service).is_running
        assert not host.service(service).is_enabled
