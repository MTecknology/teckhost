ferm:
  pkg.installed: []
  file.managed:
    - name: /etc/ferm/ferm.conf
    - source: salt://ferm/ferm.conf
    - template: jinja
    - require:
      - pkg: salt-minion
  service.running:
    - enable: True
    - sig: init
    - require:
      - pkg: ferm
    - watch:
      - file: ferm
