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
    - drivers
    - basics
    - cleanup
    - ntp
    - pam
    - pcsupport
    - salt
    - security
    - sudo
    - users
    - user_policies

    # Hostname(Role)-Based Extras [all lines should have 4 spaces]
{% include '_hosts/' ~ salt.grains.get('id').split('.')[0] ignore missing %}

  # Laptop w/ Gnome3
  '*pc*':
    - desktop.cinnamon
    - teckhost_users

  # Managed Device
  '*pcm*':
    - teckhost_agent.client

  # Test Systems
  'test*':
    - ssh

  # Dev Systems
  'dev*':
    - ssh
