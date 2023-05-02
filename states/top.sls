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

    # Hostname(Role)-Based Extras [all lines should have 4 spaces]
{% include '_hosts/' ~ salt.grains.get('id').split('.')[0] ignore missing %}

  # Laptop w/ Gnome3
  '*pc*':
    - desktop.cinnamon
    - grub
    - pcsupport
    - teckhost_users
    - user_policies

  # Managed Device
  '*pcm*':
    - teckhost_agent.client

  # Test Systems
  'test*':
    - ssh

  # Dev Systems
  'dev*':
    - ssh
