/etc/apt/sources.list:
  file.managed:
    - source: salt://apt/sources.list
    - template: jinja
    - require:
      - file: /etc/apt/preferences.d/pinning

/etc/apt/preferences.d/pinning:
  file.managed:
    - source: salt://apt/pinning.prefs
    - template: jinja
