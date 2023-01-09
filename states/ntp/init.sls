chrony:
  pkg.installed: []
  file.managed:
    - name: /etc/chrony/chrony.conf
    - source: salt://ntp/chrony.conf
    - template: jinja
    - require:
      - pkg: chrony
  service.running:
    - enable: True
    - require:
      - pkg: chrony
    - watch:
      - file: chrony
