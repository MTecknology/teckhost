#!/usr/bin/env python3
'''
Source: CIS_Distribution_Independent_Linux_Benchmark_v2.0.0.pdf
Implements: 1.3 Filesystem Integrity Checking
'''
import pytest


@pytest.mark.skip(reason='no central logging solution')
class TestIDS:

    def test_ids_installed(self, host):
        '''1.3.1 Ensure IDS is installed'''
        assert any(host.package(p).is_installed for p in ['aide', 'hashdeep']), \
            'IDS not installed'

    def test_ids_scheduled(self, host):
        '''1.3.2 Ensure filesystem integrity is regularly checked'''
        probe = host.run('grep -qRE "(aide|hashdeep)" /etc/cron*')
        assert probe.rc == 0, 'No IDS cron entry was found'
        stdout = probe.stdout.strip()
        assert stdout == ''
