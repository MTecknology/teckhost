#!/usr/bin/env python3
'''
Source: CIS_Distribution_Independent_Linux_Benchmark_v2.0.0.pdf
Implements: 1.5 Additional Process Hardening
'''
import pytest
from conftest import SUDO_WRAPPER


class TestProcesses:

    def test_limits_coredump(self, host):
        '''1.5.1 Ensure core dumps are restricted'''
        probe = host.run('grep "hard core" -R /etc/security/limits.*')
        assert probe.rc == 0, 'limits.conf is missing "* hard core 0"'
        stdout = probe.stdout.strip()
        assert '* hard core 0' in stdout
        # Part 2: sysctl fs.suid_dumpable
        assert host.sysctl('fs.suid_dumpable') == 0
        # Part 3: systemd-coredump
        assert not host.package('systemd-coredump').is_installed

    @pytest.mark.admin
    def test_xdnx_active(self, host):
        '''1.5.2 Ensure XD/NX support is enabled'''
        virtname = host.file('/sys/devices/virtual/dmi/id/product_name').content_string
        if virtname.strip() in ['VirtualBox']:
            pytest.skip('Cannot succeed in virtual environment')
        probe = host.run(f'{SUDO_WRAPPER} journalctl | grep "protection: active"')
        assert probe.rc == 0, 'No protection information found'
        stdout = probe.stdout.strip()
        assert 'kernel: NX (Execute Disable) protection: active' in stdout

    def test_sysctl_aslr(self, host):
        '''1.5.3 Ensure address space layout randomization (ASLR) is enabled'''
        assert host.sysctl('kernel.randomize_va_space') == 2

    def test_prelink_missing(self, host):
        '''1.5.4 Ensure prelink is disabled'''
        assert not host.package('prelink').is_installed
