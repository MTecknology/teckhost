#!/usr/bin/env python3
##
# Simple "helper" functions for better testing
##


def please(host, command):
    '''
    Like sudo, but provides sudo password for test{admin,user}
    '''
    return host.run(f'echo SuperInsecurePassword4Testing | sudo -S {command}')
