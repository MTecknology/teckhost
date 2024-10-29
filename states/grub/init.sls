grub:
  pkg.installed:
    - names:
      - grub2-common
      - procps

{% for grubconf in ['01_admin', '10_linux'] %}
/etc/grub.d/{{ grubconf }}:
  file.managed:
    - source: salt://grub/{{ grubconf }}
    - template: jinja
    - mode: '0755'
    - require:
      - pkg: grub
    - watch_in:
      - cmd: update-grub
{% endfor %}

/etc/default/grub:
  file.managed:
    - source: salt://grub/grub
    - template: jinja

update-grub:
  cmd.run:
    {% if salt.environ.get('container', False) %}
    - name: /bin/true
    {% endif %}
    - onchanges:
      - file: /etc/default/grub
