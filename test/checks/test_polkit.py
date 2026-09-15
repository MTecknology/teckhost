#!/usr/bin/env python3
##
# Validation Tests: Polkit
##
import pytest
from conftest import SUDO_WRAPPER


@pytest.mark.admin
def test_polkit_rules_loaded(host):
    '''Expect polkitd to compile every rules file it reads'''
    if not host.package('polkitd').is_installed:
        pytest.skip('Polkit Not Found')
    assert host.service('polkit').is_running
    rules = []
    for rulesdir in ['/etc/polkit-1/rules.d', '/run/polkit-1/rules.d',
                     '/usr/local/share/polkit-1/rules.d', '/usr/share/polkit-1/rules.d']:
        if host.file(rulesdir).is_directory:
            probe = host.run(f'{SUDO_WRAPPER} find {rulesdir} -name "*.rules"')
            assert probe.rc == 0, f'unable to list {rulesdir}'
            rules.extend(probe.stdout.split())
    probe = host.run(f'{SUDO_WRAPPER} journalctl -u polkit -o cat _SYSTEMD_INVOCATION_ID=$(systemctl show -p InvocationID --value polkit)')
    assert probe.rc == 0, 'unable to read polkit journal'
    finished = [line for line in probe.stdout.splitlines() if line.startswith('Finished loading')]
    assert finished, 'polkitd has not loaded any rules'
    assert finished[-1] == f'Finished loading, compiling and executing {len(rules)} rules', \
        'polkitd did not compile every rules file'
