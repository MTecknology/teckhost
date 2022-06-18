MTecknology Host
================

This repository is used to automate the building, testing, deployment, and
maintenance of servers and endpoints that are managed by MTecknology.

To Do
-----

- Apps to consider: virtualgl, virtualbox, nvidia-driver
- Printer/Scanner
- firstlogin created on irc host (check rendered sls after test deploy)

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

Usage Example::

    # Tell build_iso to download the current installer
    export TH_SRC='https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/current/amd64/iso-cd/firmware-11.3.0-amd64-netinst.iso'
    export TH_CKSUM='eba7ce7823681a610f9f23d6468976517ed92b6b90acec4ac55df62b0a090050bba0145ef5c07f544b92569cd10e9572f4e9f7c3415b3323abffa51cd7c5d4f4'

    # Build the modified ISO
    make teckhost.iso
    mbuffer -i teckhost.iso -o /dev/sda


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

Usage Example::

    ./build_iso -i ~/downloads/debian-11.3.0-amd64-netinst.iso -o ~/teckhost.iso
    sudo mbuffer -i teckhost.iso -o /dev/sda

.. _version w/ firmware: https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/current/amd64/iso-cd/
