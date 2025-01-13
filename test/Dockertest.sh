#!/bin/sh
##
# Primary entry point for testing within containers.
#
# NOTE: The root of this repo should be mounted to /etc/ansible.
##
set -e

##
# Run Bootstrap (&& Ansible)
##

# Defaults from .github/workflows/cicd.yml::THT_GRUBTEST)
export TH_ANSGPG="${TH_ANSGPG:-/etc/ansible/conf/_test/key.gpg}"
export BS_PLAYBOOK="${BS_PLAYBOOK:-/etc/ansible/conf/_test/maintenance.yml}"

# Password for test data (based on iso/debconf_early)
printf 'AWeakLink' >/tmp/gpgpassphrase

# Bootstrap -> Ansible -> Maintenance(.yml)
/etc/ansible/bootstrap


##
# Run tests
##

# Run pytest and exit
cd /etc/ansible && pytest --type=container
