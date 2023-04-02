{% for grubconf in ['01_admin', '10_linux'] %}
/etc/grub.d/{{ grubconf }}:
  file.managed:
    - source: salt://security/{{ grubconf }}
    - template: jinja
    - mode: '0755'
    - watch_in:
      - cmd: update-grub
{% endfor %}

/etc/default/grub:
  file.managed:
    - source: salt://security/grub
    - template: jinja

update-grub:
  cmd.wait:
    - watch:
      - file: /etc/default/grub
