/etc/apt/sources.list:
  file.managed:
    - contents: |
        deb http://deb.debian.org/debian/ bullseye main non-free contrib
        deb http://security.debian.org/debian-security bullseye-security main non-free contrib
        deb http://deb.debian.org/debian/ bullseye-updates main non-free contrib
        deb http://deb.debian.org/debian/ sid main non-free contrib
    - require:
      - file: /etc/apt/preferences.d/pinning

/etc/apt/preferences.d/pinning:
  file.managed:
    - contents: |
        Package: *
        Pin: release n=bullseye
        Pin-Priority: 900

        Package: *
        Pin: release n=sid
        Pin-Priority: 800
