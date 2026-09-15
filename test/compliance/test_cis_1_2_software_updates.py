#!/usr/bin/env python3
'''
Source: CIS_Distribution_Independent_Linux_Benchmark_v2.0.0.pdf
Implements: 1.2 Configure Software Updates
'''
import pytest


class TestSoftwareUpdates:

    def test_repoconfig_debian(self, host):
        '''1.2.1 Ensure package manager repositories are configured'''
        if host.system_info.distribution != 'debian':
            pytest.skip('apt-only check')
        probe = host.run('apt-cache policy | grep http | grep -Ev "(debian.org|signal.org)"')
        assert probe.rc == 1, 'unexpected exit status'
        stdout = probe.stdout.strip()
        assert stdout == ''

    def test_repokeys(self, host):
        '''1.2.2 Ensure GPG keys are configured'''
        if host.system_info.distribution != 'debian':
            pytest.skip('apt-only check')
        probe = host.run('grep -h "^Signed-By:" /etc/apt/sources.list.d/*.sources')
        assert probe.rc == 0, 'no source declares a Signed-By keyring'
        keyrings = [line.split(':', 1)[1].strip()
                    for line in probe.stdout.strip().splitlines()]
        for keyring in keyrings:
            assert host.file(keyring).exists, f'{keyring} is missing'
