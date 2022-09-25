/etc/apt/sources.list:
  file.managed:
    - contents: |
        deb http://deb.debian.org/debian/ bullseye main non-free contrib
        deb http://security.debian.org/debian-security bullseye-security main non-free contrib
        deb http://deb.debian.org/debian/ bullseye-updates main non-free contrib
        deb http://deb.debian.org/debian/ testing main non-free contrib
        deb http://deb.debian.org/debian/ sid main non-free contrib
    - require:
      - file: /etc/apt/preferences.d/pinning

/etc/apt/preferences.d/pinning:
  file.managed:
    - contents: |
        Package: *
        Pin: release a=stable
        Pin-Priority: 700

        Package: *
        Pin: release a=stable-security
        Pin-Priority: 700

        Package: *
        Pin: release a=testing
        Pin-Priority: 400

        Package: *
        Pin: release a=unstable
        Pin-Priority: 300
