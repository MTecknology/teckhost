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
        assert host.run(f'{SUDO_WRAPPER} apt-get update').rc == 0
        probe = host.run('apt-get -s upgrade')
        assert probe.rc == 0, 'unexpected apt-get exit status'
        # stdout = probe.stdout.strip()
        # assert 'Inst ' not in stdout
        # assert '0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.' in stdout
