rsyslog:
  pkg.installed: []
  file.managed:
    - name: /etc/rsyslog.conf
    - source: salt://rsyslog/rsyslog.conf
    - require:
      - pkg: rsyslog
    - watch_in:
      - service: rsyslog
  service.running:
    - require:
      - pkg: rsyslog

journald:
  file.managed:
    - name: /etc/systemd/journald.conf
    - source: salt://rsyslog/journald.conf
    - require:
      - service: auditd
#  service.running:
#    - name: systemd-journald
#    - watch:
#      - file: journald
#    - require:
#      - service: rsyslog
