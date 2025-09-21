#!/usr/bin/env python3
'''
Source: CIS_Distribution_Independent_Linux_Benchmark_v2.0.0.pdf
Implements: 1.1 Filesystem Configuration
'''
import pytest
from conftest import SUDO_WRAPPER


class TestUnusedFilesystems:
    '''1.1.1 Disable unused filesystems'''
    FSLIST = [
        'cramfs',    # 1.1.1.1
        'freevxfs',  # 1.1.1.2
        'jffs2',     # 1.1.1.3
        'hfs',       # 1.1.1.4
        'hfsplus',   # 1.1.1.5
        'squashfs',  # 1.1.1.6
        'udf',       # 1.1.1.7
        # 'vfat',      # 1.1.1.8 - common use
    ]

    @pytest.mark.parametrize('filesystem', FSLIST)
    def test_filesystem_unloaded(self, host, filesystem):
        '''1.1.1.X Ensure mounting of <filesystem> filesystems is disabled'''
        probe = host.run(f'lsmod | grep -q {filesystem}')
        assert probe.rc != 0, f'{filesystem} kernel module is currently loaded'
        assert probe.stdout == ''

    @pytest.mark.breaks_oci
    @pytest.mark.admin
    @pytest.mark.parametrize('filesystem', FSLIST)
    def test_filesystem_disabled(self, host, filesystem):
        '''1.1.1.X Ensure mounting of <filesystem> filesystems is disabled'''
        probe = host.run(f'{SUDO_WRAPPER} modprobe -n -v {filesystem}')
        assert probe.rc == 0, 'unexpected modprobe exit status'
        stdout = probe.stdout.strip()
        assert any(s in stdout for s in ['install /bin/false', 'install /bin/true']), \
            f'{filesystem} is not installed with /bin/false or /bin/true'


@pytest.mark.admin
@pytest.mark.breaks_oci
class TestMountPoints:
    '''1.1.X (except 1.1.1.X) Ensure <mountpoint> is configured'''
    MOUNTPOINTS = {
        '/tmp': {       # 1.1.[2-4]
            # 1.1.5 (noexec) - nvidia conflicts
            'required_options': ['nodev', 'nosuid'],
        },
        '/var': {       # 1.1.6
            'required_options': [],
        },
        '/var/tmp': {   # 1.1.[7-10]
            'required_options': ['nodev', 'nosuid', 'noexec'],
        },
        '/var/log': {   # 1.1.11
            'required_options': [],
        },
        # '/var/log/audit': { # 1.1.12 - benefit disputed
        #     'required_options': [],
        #     },
        '/home': {      # 1.1.[13-14]
            'required_options': ['nodev'],
        },
        '/dev/shm': {   # 1.1.[15-16]
            # 1.1.17 (noexec) - nvidia conflicts
            'required_options': ['nodev', 'nosuid'],
        },
    }

    @pytest.mark.parametrize('mountpoint', MOUNTPOINTS.keys())
    def test_mount_path(self, host, mountpoint):
        '''1.1.X Ensure separate partition exists for <mountpoint>'''
        probe = host.mount_point(mountpoint)
        assert probe.exists, f'{mountpoint} is not a mount point'
        # 1.1.X Ensure <required_option> option set on <mountpoint> partition
        required_options = self.MOUNTPOINTS[mountpoint]['required_options']
        assert all(opt in probe.options for opt in required_options), \
            f'{mountpoint} is missing at least one required mount option: {required_options}'

    def test_mount_removable(self):
        '''1.1.[18-20] Ensure <required_option> option set on removable media partitions'''
        # No practical tests provided
        pass


@pytest.mark.admin
class TestFilesystemConfiguration:

    @pytest.mark.breaks_oci
    def test_stickybit_worldwriteable(self, host):
        '''1.1.21 Ensure sticky bit is set on all world-writable directories'''
        probe = host.run(r"df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null")
        assert probe.rc != 0, 'unexpected exit status'
        stdout = probe.stdout.strip()
        assert stdout == '', 'sticky bit was not set on a world-writable directory'

    @pytest.mark.breaks_oci
    def test_disable_automount(self, host):
        '''1.1.22 Disable Automounting (Scored)'''
        probe = host.service('autofs')
        assert not probe.is_running
        assert not probe.is_enabled

    def test_disable_usbstorage(self, host):
        '''1.1.23 Disable USB Storage'''
        # Not practical to enforce
        pass
