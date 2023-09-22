include:
  - basics

/etc/apt/sources.list:
  file.managed:
    - source: salt://apt/sources.list_{{ salt.grains.get('osfinger') }}
    - template: jinja
    - require:
      - file: /etc/apt/preferences.d/pinning
    - require_in:
      - pkg: base_pkgs

/etc/apt/preferences.d/pinning:
  file.managed:
    - source: salt://apt/pinning.prefs
    - template: jinja
