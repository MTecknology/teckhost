.. _hacking:

Teckhost Hacking
================

1. Read the comments.
2. Write comments.

.. _todo:

To Do
-----

Future Cleanup:

- After virtualbox reaches testing and/or stable
- After salt>=3004.0 reaches stable

Roadmap/Goldplating:

- Move "teckhost_agent" to salt states

.. _quickstart:

Quickstart
----------

Install dependencies::

    apt install virtualbox libarchive-tools syslinux xorriso isolinux

Download and cache "latest" ``debian-netinst.iso``::

    # TH_SRC can also be a local path (TH_CKSUM will be ignored)
    export TH_SRC='https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/current/amd64/iso-cd/firmware-11.3.0-amd64-netinst.iso'
    export TH_CKSUM='eba7ce7823681a610f9f23d6468976517ed92b6b90acec4ac55df62b0a090050bba0145ef5c07f544b92569cd10e9572f4e9f7c3415b3323abffa51cd7c5d4f4'

Build the Default ISO::

    make teckhost.iso
    OR
    make teckhost-sda.iso
    OR
    make teckhost-nvme0n1.iso

Run tests::

    make test

Build and log in to dev box (requires virtualbox)::

    make devpc1
    make devpc1-ssh

.. _branches:

Branches
--------

- master: Production Deployment
- deploy: CI/CD Pipeline

All changes are pushed to ``deploy`` and then promoted to ``master`` after
the CI/CD (build+install+validate) tests pass. The ``master`` branch should be
protected to prevent unexpected changes.

.. _devdir:

devdir
------

The ``devdir`` is a salt grain that provides ``salt-minion`` a local file
system path where states should be found--instead of git.

.. note::
    The ``devdir`` variable will have different values in different scripts.
    1) /srv/salt inside the vm; 2) $PWD outside the vm

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

Preseed
~~~~~~~

In order to provide as few prompts as possible, the default ``teckhost.iso``
includes a preseed file that makes assumptions about hardware (nvme, >100G).
This preseed file has two primary goals: 1) get minimum information (wifi,
hostname, decryption key(s)) from the user, and 2) use :ref:`Salt Bootstrap
<bootstrap>` to run a ``highstate``.

Makefile
--------

Key Targets:

- ``make teckhost.iso``
- ``make teckhost-sda.iso``
- ``make test``
- ``make devpc1``
- ``make devpc1-ssh``
- ``make devpc1-root``
- ``make clean``

.. _version w/ firmware: https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/current/amd64/iso-cd/
