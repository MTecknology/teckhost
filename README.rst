- Build: |cicd-init|
- Issues: |issues|

.. _teckhost:

MTecknology Host
================

This repository is used to automate the building, testing, deployment, and
maintenance of servers and endpoints that are managed by MTecknology (Mike L.).

Primary Goals:

- Provide a :ref:`bootstrap script <bootstrap>` to get a system "enrolled" into
  teckhost management
- Provide a bare metal installer, similar to debian-installer
- Automatically run a full CI/CD (build+install+validate) pipeline on any change

Secondary Goals:

- Provide the ability to test with local file system changes
- Limit user interaction to env (wifi, hostname) and encryption questions
- Implement CI/CD release process to automatically promote after tests pass
- Provide automated "release" of all "static assets" (teckhost.iso, bootstrap)

Deployment
----------

VPS:

1. Implement Salt-Cloud (or manually create)
2. Log in and run :ref:`Salt Bootstrap <bootstrap>`
3. Provide keys

Bare Metal:

1. `Download`_ or :ref:`Build <build-iso>` ISO
2. Copy ISO to flash drive (with ``mbuffer`` or ``dd``)
3. Boot to installer and choose either LVM or Encrypted
4. Provide network/hostname/keys

.. figure:: .github/misc/teckhost_lifecycle.svg
    :align: center
    :alt: teckhost-lifecycle

GA Prebuild
-----------

Prior to Teckhost v1.2, Github Actions ran through the entire build process,
including a fresh installation from a generated VM. Each Github Action workflow
took 40-80 minutes to complete and often took multiple attempts before success.

Starting with v1.2, a manually-generated OVA is uploaded to the github release
and then used by future workflows to prime the installation.

To create ``testpc1.ova``:

1. ``make clean test``
2. Wait for all tests to succeed
3. Within VM::

   # Update
   apt update
   apt upgrade -y
   reboot  # if kernel was updated

   # Clean apt
   apt autoremove -y
   apt clean
   rm /var/lib/apt/lists/* 2>/dev/null

   # Fix boot
   /sbin/grub-install --target=x86_64-efi --efi-directory=/boot/efi --removable --boot-directory=/boot/efi --bootloader-id=grub /dev/sda1

   # Reclaim zeros
   service cron stop
   for i in / /var/ /tmp/; do cat /dev/zero >"${i}zero"; rm "${i}zero"; done
   shutdown -h now

4. Compress disk::

   VBoxManage modifyhd --compact testpc1/disk0.vdi

5. VBox > Machine > Export to OCI

   - Format: v2.0
   - File: testpc1_debian12-v0.0.ova  [template]
   - Product: Teckhost
   - Product-URL: https://github.com/MTecknology/teckhost
   - Version: v0.0
   - CPU: 2
   - RAM: 1024 MB

6. Upload this OVA file to GCP Cloud Storage
7. Edit Access > ``Public, allUsers, Reader``
8. Update file and checksum in ``Makefile`` (use "Public URL" link)
9. Push the change and verify tests succeed

.. _bootstrap:

Salt Bootstrap
--------------

Salt is at the core of deployment and maintenance. Package selection, user
creation, security policies, etc. is all done by salt during a
`state.highstate`_. The ultimate goal of this ``./bootstrap`` script is to run
the ``highstate`` as quickly and safely as possible.

In order for this ``./bootstrap`` script to complete, it will need to prompt for
a passphrase to decrypt salt's :ref:`Pillar Data <pillar>` keys.

To run the bootstrap::

    wget https://raw.githubusercontent.com/mtecknology/teckhost/master/bootstrap
    bash bootstrap

.. _pillar:

Pillar Data
~~~~~~~~~~~

In order to read encrypted "pillar" data, salt needs access to a gpg key; this
is stored in this repository in an encrypted blob. The :ref:`Salt Bootstrap
<bootstrap>` script will expect the user to have access to this private key in
order to decrypt the blob.

Ideally, only pre-hashed values will be stored in pillar. For example, a
password hash generated with ``crypt`` is encrypted for salt, rather than the
password itself. *This repository is highly exposed and nothing within, even
encrypted, should be considered more secure than the test data.*

To encrypt data for pillar::

    # Import the public key
    curl -s https://raw.githubusercontent.com/MTecknology/teckhost/master/pillar/teckhost.pub | gpg --import

    # Pipe the secret data through gpg
    echo -n 'S3cr!t' | gpg --trust-model always -ear salt@teckhost.lustfield.net

.. _Download: https://github.com/MTecknology/teckhost/releases

.. _state.highstate: https://docs.saltproject.io/en/latest/topics/tutorials/states_pt1.html


.. |cicd-release| image:: https://github.com/MTecknology/teckhost/actions/workflows/cicd.yml/badge.svg?branch=cicd-release
    :target: https://github.com/MTecknology/teckhost/actions/workflows/cicd.yml
    :alt: CI/CD

.. |cicd-init| image:: https://github.com/MTecknology/teckhost/actions/workflows/cicd.yml/badge.svg?branch=master
    :target: https://github.com/MTecknology/teckhost/actions/workflows/cicd.yml
    :alt: CI/CD

.. |issues| image:: https://img.shields.io/github/issues/MTecknology/teckhost.svg
    :target: https://github.com/MTecknology/teckhost/issues
    :alt: Github Issues
