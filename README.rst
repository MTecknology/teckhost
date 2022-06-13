MTecknology Host
================

After using a fully-public repository to deploy, configure, and back up a server
running an IRC bot and debating a replacement auto-deploy tool for personal
devices, I decided to build a solution that was flexible enough that it too
could be left in public view and be used to manage personal and family devices.

To Do
-----

- Why does salt hang with lvm.lv_absent(scratch)?
  + Is this only within d-i?
- Should nvidia-driver be installed?
  + Is it worth benchmarking?
- Option to test with "local" data instead of git[master].
- Install virtualbox
- Install VirtualGL?
  + Is it really worth the headache?

Deployment
----------

Salt is the primary tool for maintaining systems. Most of the deployment process
is wrapper processes meant to get salt installed and running as quickly as
possible. Salt installation is meant to be done using a ``bootstrap`` script
which can be triggered at the end of a machine installation or VPS creation.

General Process:

1. Obtain a copy of a current netinstall iso (most likely `version w/ firmware`_)
2. Build ISO with ``./build_iso -i <netinst.iso> -o ~/teckhost.iso``
3. Copy ISO to flash drive (with mbuffer or dd)
4. Insert flash drive and select as **EFI** boot device
5. Boot to ISO and choose either LVM or Encrypted
6. Provide network/hostname/keys
7. Wait for completion notice; "Running preseed ..." will take a while to run

Salt Bootstrap
~~~~~~~~~~~~~~

The primary method of installing salt is using the ``bootstrap`` script, which
expects the user to provide a passphrase (for Encrypted Data).

To run the bootstrap::

    wget https://raw.githubusercontent.com/mtecknology/teckhost/master/bootstrap
    bash bootstrap

Encrypted Data
~~~~~~~~~~~~~~

In order to read encrypted "pillar" data, salt needs access to a gpg key; this
is stored in this repository in a gpg-encrypted blob. The bootstrap script will
expect the user to have access to this private key in order to decrypt the blob.

Ideally, only pre-hashed values will be stored in pillar. For instance, user
accounts should have a password hash generated with ``crypt`` prior to passing
the hash to salt for gpg-based encryption.

To encrypt a password suitable for usage in pillar data::

    # Import the public key
    gpg --import teckhostpub.gpg

    # Pipe the secret data through gpg
    echo -n 'S3cr!t' | gpg --trust-model always -ear salt@teckhost.lustfield.net


Preseed
-------

The intended use of the ``bootstrap`` script is at the end of a "standard" OS
install. This can either be done by logging into an installed system to execute
as root, or by the installer itself (via preseed).

The ``iso/build_iso`` script will unpack an existing ISO, inject preseed files,
update grub menu options, and repack a new ISO that can be used for
installation.

Example usage::

    ./build_iso -i ~/downloads/debian-11.3.0-amd64-netinst.iso -o ~/teckhost.iso
    sudo mbuffer -i teckhost.iso -o /dev/sda

Install Options
---------------

I ran into many issues when trying to provide multiple preseed files on the same
install media. The files could be found by passing file=preseed-foo.cfg, but
then md5sums needed to be added to the grub config, and other issues followed.
Embedding a preseed just works best when there's a single file named
``preseed.cfg``.

In order to provide multiple installation options while using the same
``preseed.cfg``, environment variables (i.e. ``$TEMPLATE_METHOD``) are passed as
grub boot arguments (see: ``auto-grub.cfg``). During ``d-i partman/early_command``,
a special "preload" function (``debconf_preload()``) in the ``bootstrap`` script is
run that uses ``db_set`` to update the installer environment from environment
variables.

This is a long-winded way to set d-i options from grub menu entries. There's
probably a better way, but I haven't found it.

Common Issues
-------------

- Boot menu displays standard installation menu.

Current modifications are for EFI boots ONLY.

Ngxbot Host
-----------

This repository was cloned from https://github.com/ngx/ngxbot-host.

.. _version w/ firmware: https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/current/amd64/iso-cd/
