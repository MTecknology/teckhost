#!/usr/bin/env python3
# -*- coding: utf-8 -*-
'''
Run validation tests against a host installed in "testing" mode.

Usage:
  python3 -m pytest \
    --ssh-config=test/.ssh/config --ssh-identity-file=test/.ssh/id_ed25519 \
    --hosts=ssh://testuser@testpc1 --type user
'''
import pytest


# Simple wrapper to run a command using sudo with known password
SUDO_WRAPPER = 'echo SuperInsecurePassword4Testing | sudo -S'


def pytest_addoption(parser):
    '''
    Add extra options to pytest command. See: ``pytest --help``
    '''
    parser.addoption(
        '--type', choices=['user', 'admin', 'container'], default='user',
        help='Some tests expect user-level access and some expect admin; container testing is for testing within podman')


def pytest_configure(config):
    '''
    Add extra configuration options.
    '''
    config.addinivalue_line(
        'markers',
        'user: mark a test to run only for standard (non-admin) users')
    config.addinivalue_line(
        'markers',
        'admin: mark a test to run only for admin users')
    config.addinivalue_line(
        'markers',
        'breaks_oci: mark a test to skip when type=container')


def pytest_collection_modifyitems(config, items):
    '''
    Modify collected test stack.
    '''
    for item in items:

        # Add '@pytest.mark.admin' decorator to test function only with type=admin
        if 'admin' in item.keywords and config.getoption('--type') == 'user':
            item.add_marker(pytest.mark.skip(reason='user-only test'))

        # Add '@pytest.mark.user' decorator to test function only with type=user
        if 'user' in item.keywords and config.getoption('--type') == 'admin':
            item.add_marker(pytest.mark.skip(reason='admin-only test'))

        # Add '@pytest.mark.breaks_oci' decorator to skip for container type
        # Note: Assumes *all* (admin and user) tests will be performed.
        if 'breaks_oci' in item.keywords and config.getoption('--type') == 'container':
            item.add_marker(pytest.mark.skip(reason='breaks OCI containers'))
