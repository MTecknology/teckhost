base:

  '*':
    # Basic Inclusions
    - basics
    - cleanup
    - apt
    #- ferm : obsolete, need a replacement
    - salt
    - sudo
    - users
    - teckhost_users

  'efi-secure-boot:True':
    - match: grain
    - mokcert

    # Hostname(Role)-Based Extras [all lines should have 4 spaces]
{% include '_hosts/' ~ salt.grains.get('id').split('.')[0] ignore missing %}

  # Laptop w/ Gnome3
  '*pc*':
    - desktop.gnome3

  # Managed Device
  '*pcm*':
    - teckhost_agent.client

  # Test Systems
  'test*':
    - ssh

  # Dev Systems
  'dev*':
    - ssh
