/etc/grub.d/01_admin:
  file.managed:
    - source: salt://security/01_admin
    - template: jinja
    - mode: '0755'

/etc/default/grub:
  file.managed:
    - source: salt://security/grub
    - template: jinja

update-grub:
  cmd.wait:
    - watch:
      - file: /etc/grub.d/01_admin
      - file: /etc/default/grub
