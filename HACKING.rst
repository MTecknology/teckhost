.. _hacking:

Teckhost Hacking
================

1. Read the comments.
2. Write comments.

Ansible Notes
-------------

**USE CAUTION WITH:**

- ``ansible.builtin.service``: It breaks d-i and container environments.

   Instead, use::

       ansible.builtin.command:
         cmd: service <NAME> start
       register: <NAME>_start
       changed_when: "<NAME>_start.rc != 0"

   If ``command`` (^) breaks containers, use:
   ``service`` with ``when: not partial_install``

.. _quickstart:

Quickstart
----------

Install dependencies::

    apt install virtualbox libarchive-tools syslinux xorriso isolinux

Download and cache "latest" ``debian-netinst.iso``::

    # TH_SRC can also be a local path
    TH_SRC='https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/current/amd64/iso-cd/firmware-11.3.0-amd64-netinst.iso'
    TH_CKSUM='eba7ce7823681a610f9f23d6468976517ed92b6b90acec4ac55df62b0a090050bba0145ef5c07f544b92569cd10e9572f4e9f7c3415b3323abffa51cd7c5d4f4'
    wget "$TH_SRC" "../$TH_CKSUM.iso"

Build the Default ISO::

    make teckhost.iso

Run tests::

    make test

Build and log in to dev box (requires virtualbox)::

    make testpc1
    make testpc1-ssh

.. _branches:

Branches
--------

- cicd-release: Production Deployment
- master: Root of CI/CD Pipeline

All changes are pushed to ``master`` and then promoted to ``cicd-release`` after
the CI/CD (build+install+validate) tests pass. The ``cicd-release`` branch should
be protected to prevent unexpected changes.

.. _Deployment:

Deployment
----------

Ansible is the primary tool for maintaining systems. Most of the deployment process
is wrapper processes meant to get ansible installed and running as quickly as
possible. Ansible installation is meant to be done using the ``bootstrap`` script
which can be triggered at the end of a machine installation or VPS creation.

General Process:

1. Obtain Debian ISO
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
hostname, decryption key(s)) from the user, and 2) use :ref:`Teckhost Bootstrap
<bootstrap>` to run a ``highstate``.

Makefile
--------

Key Targets:

- ``make teckhost.iso``
- ``make test``
- ``make full-test``
- ``make playpod-<distro>``
- ``make ssh-testpc1-user``
- ``make ssh-testpc1-admin``
- ``make clean``
