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

    # Hostname(Role)-Based Extras
    {% filter indent(width=4, indentfirst=0) -%}
    {% include '_hosts/' ~ salt.grains.get('id').split('.')[0] ignore missing %}
    {% endfilter %}

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
