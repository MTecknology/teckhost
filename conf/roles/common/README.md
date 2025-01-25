Role: Common
============

This role covers basic server configuration that is expected across all servers.

**Tasks:**

- ``ntp``: Ensure chrony is correctly installed.
- ``packages``: Basic set of system packages that should be on all hosts.
- ``security``: Basic system security settings; primarily from ``CIS DIL v2``.
- ``sudo``: Ensure sudo is available, with secure configuration.
- ``users``: Manage local users, who can log into the host.
- TODO: ...
