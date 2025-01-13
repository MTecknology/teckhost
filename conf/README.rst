Ansible Configuration
=====================

**Directory Structure:**

- ``../ansible.cfg``: Configuration required for ``ansible-playbook``.
- ``maintenance.yml``: Ansible playbook that runs approriate roles.
- ``roles/``

  + ``common``: Baseline security and configuration for all devices.
  + ``custom``: Selects additional host-based roles to run specific devices.
  + ``desktop``: Provides a fully-configured desktop environment.

- ``group_vars/``: Encrypted configuration data, used by roles.
- ``key.gpg``: GPG-encrypted parent key for ``group_vars`` encryption.
- ``_test/``: Minimal copy of other data in this directory, used for testing.
