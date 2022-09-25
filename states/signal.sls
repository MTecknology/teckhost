include:
  - apt.signal

signal-desktop:
  pkg.installed:
    - require:
      - file: apt-keyring-signal
