apt-keyring-spotify:
  file.managed:
    - name: /usr/share/keyrings/spotify_5E3C.gpg
    - source: salt://apt/keyrings/spotify.gpg

apt-repo-spotify:
  file.managed:
    - name: /etc/apt/sources.list.d/spotify.list
    - contents: |
        deb [arch=amd64 signed-by=/usr/share/keyrings/spotify_5E3C.gpg] http://repository.spotify.com stable non-free
