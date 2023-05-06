#!/usr/bin/env python3
##
# Validation Tests: Users
##
import pytest


@pytest.mark.parametrize('user', ['testuser', 'testadmin'])
def test_user_present(host, user):
    '''Verify specific users are present on the system'''
    assert host.user(user).exists


@pytest.mark.parametrize('user', ['salt', 'michael', 'invaliduser', 'testgone'])
def test_user_absent(host, user):
    '''Verify specific users are absent on the system'''
    assert not host.user(user).exists
