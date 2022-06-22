.. _hacking:

Teckhost Hacking
================

1. Read the comments.
2. Write comments.

.. _branches:

Branches
--------

- master: Production Deployment
- deploy: CI/CD Pipeline

All changes are pushed to ``deploy`` and then promoted to ``master`` after
the CI/CD (build+install+validate) pipeline tests pass. The ``master`` branch
should be protected to prevent unexpected changes.

.. _devdir:

devdir
------

The ``devdir`` is a salt grain that provides ``salt-minion`` a local file
system path where states should be found--instead of git. This allows other
scripts to intercept that value and ensure the directory is shared to the VM.

1. Makefile builds an iso with ``build_iso -x BS_devdir``
2. Makefile deploys a test VM and configures the local mount
3. Bootstrap writes ``devdir`` value to salt grains
4. Bootstrap runs a ``highstate`` and updates the salt configuration file

.. _Deployment:

Deployment
----------

Salt is the primary tool for maintaining systems. Most of the deployment process
is wrapper processes meant to get salt installed and running as quickly as
possible. Salt installation is meant to be done using the ``bootstrap`` script
which can be triggered at the end of a machine installation or VPS creation.

General Process:

1. Obtain netinstall iso (most likely `version w/ firmware`_)
2. Build ISO with ``build_iso`` (Step 1 can be replaced with env vars)
3. Copy ISO to flash drive (with ``mbuffer`` or ``dd``)
4. Boot to installer and choose either LVM or Encrypted
5. Provide network/hostname/keys

.. _build-iso:

Build ISO
---------

The ``iso/build_iso`` script will take a debian installer iso as input and
produce a custom ISO which includes automated installer options (and one menu
item for recovery).

Usage Example::

    ./build_iso -i ~/downloads/debian-11.3.0-amd64-netinst.iso -o ~/teckhost.iso
    sudo mbuffer -i teckhost.iso -o /dev/sda

More information is available in the `Preseed <preseed>`_ section.

.. _preseed:

Preseed
-------

The intended use of the ``bootstrap`` script is at the end of a "standard" OS
install. This can either be done by logging into an installed system to execute
as root, or by the installer itself (via preseed).

The ``iso/build_iso`` script will unpack an existing ISO, inject preseed files,
update grub menu options, and repack a new ISO that can be used for
installation.

.. _version w/ firmware: https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/current/amd64/iso-cd/
