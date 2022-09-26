apt-keyring-virtualbox:
  file.managed:
    - name: /usr/share/keyrings/oracle-virtualbox-2016.gpg
    - source: salt://apt/keyrings/virtualbox.gpg

apt-repo-virtualbox:
  file.managed:
    - name: /etc/apt/sources.list.d/virtualbox.list
    - contents: |
        deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian bullseye contrib
