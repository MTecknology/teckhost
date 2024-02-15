#!/usr/bin/env python3
##
# Validation Tests: Highstate
##
import pytest
from conftest import SUDO_WRAPPER


@pytest.mark.admin
def test_two_highstates(host):
    '''Verify a highstate can complete with no errors and a second run produces no changes'''
    for run in range(1, 2):
        highstate = host.run(f'{SUDO_WRAPPER} /opt/salt/bin/salt-call --local --state-verbose=False state.highstate')
        assert highstate.succeeded
        assert 'Failed:0' in highstate.stdout.replace(' ', '')
        assert 'Totalstatesrun:0' not in highstate.stdout.replace(' ', '')
        if run == 2:
            assert 'changed=' not in highstate.stdout
