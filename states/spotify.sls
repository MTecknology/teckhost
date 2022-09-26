include:
  - apt.spotify

spotify:
  pkg.installed:
    - name: spotify-client
    - refresh: True
    - require:
      - file: apt-repo-spotify
