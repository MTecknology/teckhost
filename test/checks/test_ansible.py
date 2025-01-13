#!/usr/bin/env python3
##
# Validation Tests: Ansible Configuration
##
import pytest
import conftest


@pytest.mark.admin
def test_two_runs(host, pytestconfig):
    '''Verify ansible can finish with no errors and a second run produces no changes'''
    if pytestconfig.getoption('--type') == 'container':
        SUDO_WRAPPER = ''
    else:
        SUDO_WRAPPER = conftest.SUDO_WRAPPER

    for run in range(1, 2):
        result = host.run(f'{SUDO_WRAPPER} ansible-playbook /etc/ansible/conf/_test/maintenance.yml -i conf/_test/inventory.yml')
        assert result.succeeded
        ansible_stdout = result.stdout.replace(' ', '')
        assert 'unreachable=0' in ansible_stdout
        assert 'failed=0' in ansible_stdout
        assert 'ok=0' not in ansible_stdout
        if run == 2:
            assert 'changed=0' in ansible_stdout
