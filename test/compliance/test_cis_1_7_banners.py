#!/usr/bin/env python3
'''
Source: CIS_Distribution_Independent_Linux_Benchmark_v2.0.0.pdf
Implements: 1.7 Warning Banners
'''
import pytest


class TestBanners:

    def file_clean(self, fileobj):
        '''Verify a banner file is clean of problematic values'''
        assert fileobj.is_file, '/etc/motd was not found'
        bad_strings = [r'\v', r'\r', r'\m', r'\s']
        assert all(v not in fileobj.content_string for v in bad_strings), \
            'host value exposed in /etc/motd'
        # 1.7.1.[4-6] Ensure permissions on <path> are configured
        assert oct(fileobj.mode) == '0o644', 'file is not 0664'
        assert fileobj.uid == 0, 'file not owned by user:root'
        assert fileobj.gid == 0, 'file not owned by group:root'

    def test_motd_contents(self, host):
        '''1.7.1.1 Ensure message of the day is configured properly'''
        probe = host.file('/etc/motd')
        self.file_clean(probe)

    def test_issue_contents(self, host):
        '''1.7.1.2 Ensure local login warning banner is configured properly'''
        probe = host.file('/etc/issue')
        self.file_clean(probe)

    def test_issuenet_contents(self, host):
        '''1.7.1.3 Ensure remote login warning banner is configured properly'''
        probe = host.file('/etc/issue.net')
        self.file_clean(probe)

    @pytest.mark.skip(reason='provides no value on personal device')
    def test_gdm_banner(self, host):
        '''1.7.2 Ensure [DM] login banner is configured'''
        probe = host.run('grep "^session-setup-script=/" /etc/lightdm/lightdm.conf')
        assert probe.rc == 0
