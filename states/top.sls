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

  # Server
  'not *pc*':
    - match: compound
    - ssh

  # Laptop w/ Gnome3
  '*pc*':
    - desktop.cinnamon
    - grub
    - pcsupport
    - user_policies
    - signal

  # Test/Dev Systems
  'test* or dev*':
    - match: compound
    - ssh

  'forwarder*':
    - webapps

  'mikepc*':
    - extras.mikepc
