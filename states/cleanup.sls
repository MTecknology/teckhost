# Random little things that are nice to clean up after a system is deployed.

/tmp/gpgpassphrase:
  file.absent: []

/tmp/bootstrap:
  file.absent: []

debconf-cleanup:
  debconf.set:
    - data:
        'netcfg/wireless_show_essids': {'type': 'select', 'value': ''}
        'netcfg/wireless_essid': {'type': 'string', 'value': ''}
        'netcfg/wireless_wpa': {'type': 'string', 'value': ''}
        'gpgpassphrase/ask': {'type': 'string', 'value': ''}

cleanup-scratch:
  cmd.run:
    - name: lvm lvremove sys/scratch --yes
    - onlyif: test -e /dev/mapper/sys-scratch

unapproved-packages:
  pkg.purged:
    - names:
      - apache2
      - apache2-bin
      - apport
      - avahi-daemon
      - gdebi
      - gdebi-core
      - gnome-software
      - gist
      - os-prober
      - ppp
      - software-properties-gtk
      - software-properties-common
      - synaptic
      - tasksel
      - tasksel-data
      # systemd fluff
      - libnss-myhostname
      - libnss-mymachines
      - libnss-resolv
      - libnss-systemd
      - libsystemd-dev
      - libudev-dev
      - systemd-boot
      - systemd-boot-efi
      - systemd-coredump
      - systemd-cron
      - systemd-homed
      - systemd-oomd
      - systemd-standalone-sysusers
      - systemd-standalone-tmpfiles
      - systemd-tests
      - systemd-timesyncd
    - order: last  # Ensure any accidental installs are followed up with removals

package-cleanup:
  cmd.wait:
    - name: apt -y autoremove
    - watch:
      - pkg: unapproved-packages
