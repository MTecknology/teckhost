#!/usr/bin/env python3
# -*- coding: utf-8 -*-
'''
Run validation tests against a host installed in "testing" mode.

Usage:
  python3 -m pytest \
    --ssh-config=test/.ssh/config --ssh-identity-file=test/.ssh/id_ed25519 \
    --hosts=ssh://tester@testpc1 --type user
'''
import pytest


def pytest_addoption(parser):
    '''
    Add extra options to pytest command. See: ``pytest --help``
    '''
    parser.addoption(
        '--type', choices=['user', 'admin'], default='user',
        help='Some tests expect user-level access and some expect admin.')


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


def pytest_collection_modifyitems(config, items):
    '''
    Modify collected test stack.
    '''
    # Add '@pytest.mark.admin' decorator to test function only with type=admin
    skip_user = pytest.mark.skip(reason='user-only test')
    # Add '@pytest.mark.user' decorator to test function only with type=user
    skip_admin = pytest.mark.skip(reason='admin-only test')

    for item in items:
        if 'admin' in item.keywords and config.getoption('--type') == 'user':
            item.add_marker(skip_admin)
        if 'user' in item.keywords and config.getoption('--type') == 'admin':
            item.add_marker(skip_user)
