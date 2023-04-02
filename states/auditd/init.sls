auditd:
  pkg.installed: []
  file.managed:
    - name: /etc/audit/auditd.conf
    - source: salt://auditd/auditd.conf
    - require:
      - pkg: auditd
    - watch_in:
      - service: auditd
  service.running:
    - require:
      - pkg: auditd

/etc/audit/rules.d/audit.rules:
  file.managed:
    - source: salt://auditd/audit.rules
    - require:
      - pkg: auditd
    - watch_in:
      - service: auditd
