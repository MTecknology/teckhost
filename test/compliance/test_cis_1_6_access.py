#!/usr/bin/env python3
'''
Source: CIS_Distribution_Independent_Linux_Benchmark_v2.0.0.pdf
Implements: 1.6 Mandatory Access Control
'''
import pytest
from conftest import SUDO_WRAPPER


class TestMandatoryAccessControl:

    def test_mac_installed(self, host):
        '''1.6.1(.X) Ensure Mandatory Access Control Software is Installed'''
        assert host.package('apparmor').is_installed

    @pytest.mark.admin
    @pytest.mark.breaks_oci
    def test_mac_configured(self, host):
        '''1.6.[2-3](.X) Configure [MAC]'''
        probe = host.run(f'{SUDO_WRAPPER} apparmor_status')
        assert probe.rc == 0, 'unable to determine appormor status'
        stdout = probe.stdout.strip()
        assert '0 processes are unconfined' in stdout

    def test_mcstrans_disabled(self, host):
        '''1.6.2.5 Ensure the MCS Translation Service (mcstrans) is not installed'''
        assert not host.package('mcstrans').is_installed

    @pytest.mark.admin
    def test_unconfined_daemons(self, host):
        '''1.6.2.6 Ensure no unconfined daemons exist'''
        probe = host.run(f'{SUDO_WRAPPER} ps -eZ | grep -E "initrc" | grep -E -v -w "tr|ps|grep|bash|awk"')
        assert probe.rc == 1, 'potentially unconfined daemons were found'
        stdout = probe.stdout.strip()
        assert stdout == ''
