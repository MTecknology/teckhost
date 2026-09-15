#!/bin/sh
##
# Primary entry point for testing within containers.
#
# NOTE: The root of this repo should be mounted to /etc/ansible.
##
set -e

##
# Run Ansible
##

# Services cannot be managed until systemd has finished booting
count=0
while [ "$count" -lt 30 ]; do
	systemctl is-system-running 2>/dev/null | grep -qE '^(running|degraded)$' && break
	count=$((count + 1))
	sleep 1
done

# Ansible -> Maintenance(.yml)
cd /etc/ansible && ansible-playbook conf/_test/maintenance.yml


##
# Run tests
##

# Run pytest and exit
cd /etc/ansible && pytest --type=container
