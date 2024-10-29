#!/bin/sh
##
# Primary entry point for testing within containers.
#
# NOTE: The root of this repo should be mounted to /srv/salt.
##
set -e


##
# Safety Checks
##

if [ -z "$BS_gitfs_base" ]; then
	echo 'ERROR: BS_gitfs_base is a required environment variable.'
	exit 1
fi


##
# Run Bootstrap (&& Highstate)
##

# Defaults from .github/workflows/cicd.yml::THT_GRUBTEST)
export TH_SALTGPG=https://raw.githubusercontent.com/MTecknology/teckhost/master/test/pillar/skeys.gpg
export BS_devdir=/srv/salt
export BS_pillar_root=test/pillar
export BS_gitfs_pillar_base=master
#export BS_gitfs_base=<set via Makefile>

# Password for test data (based on iso/debconf_early)
printf 'AWeakLink' >/tmp/gpgpassphrase

# Bootstrap -> Highstate
/srv/salt/bootstrap


##
# Run tests
##

# Run pytest and exit
cd /srv/salt && pytest --type=container
