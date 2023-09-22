#!/usr/bin/env python3
'''
Source: CIS_Distribution_Independent_Linux_Benchmark_v2.0.0.pdf
Implements: 1.2 Configure Software Updates
'''
import distro
import pytest


class TestSoftwareUpdates:

    @pytest.mark.skipif(distro.id() != 'debian', reason='test for debian')
    def test_repoconfig_debian(self, host):
        '''1.2.1 Ensure package manager repositories are configured'''
        probe = host.run('apt-cache policy | grep http | grep -Ev "(debian.org|signal.org)"')
        assert probe.rc == 1, 'unexpected exit status'
        stdout = probe.stdout.strip()
        assert stdout == ''

    # @pytest.mark.skipif(distro.id() != 'debian', reason='test for not-debian')
    # def test_repoconfig_other(self, host):
    #     '''1.2.1 Ensure package manager repositories are configured'''
    #     assert False, 'not-implemented'

    def test_repokeys(self, host):
        '''1.2.2 Ensure GPG keys are configured'''
        # No practical tests provided
        assert True
        probe = host.run('apt-cache policy | grep http | grep -Ev "(debian.org|signal.org)"')
        assert probe.rc == 1, 'unexpected exit status'
        stdout = probe.stdout.strip()
        assert stdout == ''
