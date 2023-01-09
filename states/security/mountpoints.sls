mount-root:
  mount.mounted:
    - name: /
    - device: /dev/mapper/sys-root
    - fstype: ext4
    - opts: errors=remount-ro
    - pass_num: 1

mount-tmp:
  mount.mounted:
    - name: /tmp
    - device: /dev/mapper/sys-tmp
    - fstype: ext4
    - opts: nosuid,nodev,noexec
    - pass_num: 2

mount-var:
  mount.mounted:
    - name: /var
    - device: /dev/mapper/sys-var
    - fstype: ext4
    - opts: nosuid,nodev
    - pass_num: 2

mount-log:
  mount.mounted:
    - name: /var/log
    - device: /dev/mapper/sys-log
    - fstype: ext4
    - opts: nosuid,nodev,noexec
    - pass_num: 2

mount-home:
  mount.mounted:
    - name: /home
    - device: /dev/mapper/sys-home
    - fstype: ext4
    - opts: nosuid,nodev
    - pass_num: 2

mount-opt:
  mount.mounted:
    - name: /opt
    - device: /dev/mapper/sys-opt
    - fstype: ext4
    - opts: nosuid,nodev
    - pass_num: 2

#mount-srv:
#  mount.mounted:
#    - name: /srv
#    - device: /dev/mapper/sys-srv
#    - fstype: ext4
#    - opts: nosuid,nodev,noexec
#    - pass_num: 2

/dev/mapper/sys-swap:
  mount.swap

/var/tmp:
  mount.mounted:
    - device: tmpfs
    - fstype: tmpfs
    - opts: nodev,nosuid,noexec
