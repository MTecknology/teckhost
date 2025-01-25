#!/usr/bin/env python3
'''
Source: CIS_Distribution_Independent_Linux_Benchmark_v2.0.0.pdf
Implements: 3 Network Configuration
Not-Implemented:
- 3.[1-2] Network Parameters [non-desktop] :: Not testing server settings
- 3.3 TCP Wrappers :: This technology is superseded.
- 3.5 Firewall Configuration :: TODO - not-implemented
- 3.6 Ensure wireless interfaces are disabled :: Required for laptops
- 3.7 Disable IPv6 :: common use
'''
import pytest
from conftest import SUDO_WRAPPER


@pytest.mark.admin
@pytest.mark.breaks_oci
class TestNetworkProtocols:

    @pytest.mark.parametrize(
        'proto', [
            'dccp',     # 3.4.1
            'sctp',     # 3.4.2
            'rds',      # 3.4.3
            'tipc',     # 3.4.4
        ])
    def test_unused_protocols(self, host, proto):
        '''3.4.X Ensure <proto> is disabled'''
        # lsmod
        probe = host.run(f'lsmod | grep -q {proto}')
        assert probe.rc != 0, f'{proto} kernel module is currently loaded'
        assert probe.stdout == ''
        # modprobe
        probe = host.run(f'{SUDO_WRAPPER} modprobe -n -v {proto}')
        assert probe.rc == 0, 'unexpected modprobe exit status'
        stdout = probe.stdout.strip()
        assert any(s in stdout for s in ['install /bin/false', 'install /bin/true']), \
            f'{proto} is not installed with /bin/false or /bin/true'
