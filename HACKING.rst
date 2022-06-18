Teckhost Hacking
================

1. Read the comments.
2. Write comments.

Branches
--------

- master: Production deployment
- develop: Pre-deployment

It should no longer be possible to push directly to the ``master`` branch.
Instead, all changes must be pushed to the ``develop`` branch; this will be
automatically merged with master after tests have passed.

devdir
------

1. Makefile builds an iso with ``build_iso -x BS_devdir``
2. Makefile deploys a test VM and configures the local mount
3. Bootstrap writes ``devdir`` value to salt grains
4. Bootstrap runs a ``highstate`` and updates the salt configuration file

To Do
-----

- Protect 'master' branch
- copy (on update...) /etc/cups/printers.conf to mikepc*
- linux-headers-amd64 is not pulling in specific header packages
- use local file system for local testing
