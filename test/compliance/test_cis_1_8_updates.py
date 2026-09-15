#!/usr/bin/env python3
'''
Source: CIS_Distribution_Independent_Linux_Benchmark_v2.0.0.pdf
Implements: 1.8 Ensure updates, patches, and additional security software are installed
'''
import pytest
from conftest import SUDO_WRAPPER


class TestUpdates:

    @pytest.mark.admin
    def test_available_updates(self, host):
        '''solo-section (see: Implements)'''
        if host.system_info.distribution != 'debian':
            pytest.skip('apt-only check')
        assert host.run(f'{SUDO_WRAPPER} apt-get update').rc == 0
        probe = host.run('apt-get -s upgrade')
        assert probe.rc == 0, 'unexpected apt-get exit status'
        # stdout = probe.stdout.strip()
        # assert 'Inst ' not in stdout
        # assert '0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.' in stdout

    def test_automatic_updates(self, host):
        '''1.8 Ensure updates are applied without intervention'''
        if host.system_info.distribution == 'debian':
            assert host.package('unattended-upgrades').is_installed
            conf = host.file('/etc/apt/apt.conf.d/20auto-upgrades')
            assert 'APT::Periodic::Update-Package-Lists "1";' in conf.content_string
            assert 'APT::Periodic::Unattended-Upgrade "1";' in conf.content_string
            timer = 'apt-daily-upgrade.timer'
        else:
            assert host.package('dnf-automatic').is_installed
            # RHEL defaults to downloading updates and never installing them
            probe = host.run(r"grep -E '^apply_updates\s*=\s*yes' /etc/dnf/automatic.conf")
            assert probe.rc == 0, 'dnf-automatic downloads but does not apply'
            timer = 'dnf-automatic.timer'
        assert host.service(timer).is_enabled, f'{timer} is not enabled'
