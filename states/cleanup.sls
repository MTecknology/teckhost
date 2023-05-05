# Random little things that are nice to clean up after a system is deployed.
# NOTE: 'order' should almost always be avoided; special exceptions are noted.

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
      - deja-dup
      - duplicity
      - gdebi
      - gdebi-core
      - gnome-online-accounts
      - gnome-software
      - gist
      - malcontent
      - malcontent-gui
      - os-prober
      - pidgin
      - pidgin-data
      - ppp
      - prelink
      - python3-debian
      - software-properties-gtk
      - software-properties-common
      - spotify-client  # insecure application
      - synaptic
      - tasksel
      - tasksel-data
      - xdg-desktop-portal-gtk
      # installed via Recommends
      - exim4-daemon-light
      - exim4-config
      - exim4-base
      # systemd cruft ...
      - libnss-myhostname
      - libnss-mymachines
      - libnss-resolve
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
    - order: last  # Exception: Ensure any accidental installs are followed up with removals

package-cleanup:
  cmd.wait:
    - name: apt-get -y autoremove
    - watch:
      - pkg: unapproved-packages
