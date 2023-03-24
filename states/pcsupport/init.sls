{% from 'pcsupport/active.jinja' import conf with context -%}
include:
  - helpers

{% if conf.get('helpid') and salt.pillar.get('pcsupport') %}
pcsupport_token:
  file.managed:
    - name: /root/pcsupport.token
    - contents_pillar: "pcsupport:token"

pcsupport:
  file.managed:
    - name: /etc/systemd/system/pcsupport.service
    - source: salt://pcsupport/pcsupport.service
    - template: jinja
    - watch_in:
      - cmd: systemd-reload
  service.running:
    - name: pcsupport
    - enable: True
    - require:
      - file: pcsupport
      - file: pcsupport_token
    - watch:
      - file: pcsupport
      - file: pcsupport_token

{% else %}
# Purge previous installs
/root/pcsupport.token:
  file.absent: []

pcsupport:
  service.dead:
    - name: pcsupport
    - enable: False
{% endif %}
