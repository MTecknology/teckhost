apt-keyring-signal:
  file.managed:
    - name: /usr/share/keyrings/signal-desktop-keyring.gpg
    - source: salt://apt/keyrings/signal.gpg

apt-repo-signal:
  file.managed:
    - name: /etc/apt/sources.list.d/signal.list
    - contents: |
        deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main
