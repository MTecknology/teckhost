include:
  - apt.signal

signal-desktop:
  pkg.installed:
    - refresh: True
    - require:
      - file: apt-repo-signal
