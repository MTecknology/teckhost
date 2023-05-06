base:

  # Secure Boot / Machine Owner Key
  'efi-secure-boot:True':
    - match: grain
    - mokcert

  # Debian-Based Systems
  'os_family:Debian':
    - match: grain
    - apt

  # Baseline
  '*':
    - auditd
    - drivers
    - basics
    - cleanup
    - ntp
    - pam
    #- polkit
    - rsyslog
    - salt
    - security
    - sudo
    - users

  # Laptop w/ Gnome3
  '*pc*':
    - desktop.cinnamon
    - grub
    - pcsupport
    - user_policies
    - signal

  'mikepc*':
    - extras.mikepc

  # Test Systems
  'test*':
    - ssh

  # Dev Systems
  'dev*':
    - ssh

  # TODO: Temporary relocation
  'media*':
    - ssh
  'irc*':
    - ssh
    - irssi
    - webapps
