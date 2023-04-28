virtualbox-guest:
  pkg.latest:
    - name: virtualbox-guest-additions-iso
  cmd.wait:
    - name: 'mount /usr/share/virtualbox/VBoxGuestAdditions.iso /mnt; /mnt/VBoxLinuxAdditions.run; umount /mnt'
    - unless: 'test -e /sys/module/vboxguest'
    - watch:
      - pkg: virtualbox-guest
