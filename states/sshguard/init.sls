sshguard:
  pkg.installed:
    - require:
      - sls: apt
    - refresh: True
  file.managed:
    - name: /etc/sshguard/sshguard.conf
    - source: salt://sshguard/sshguard.conf
    - require:
      - pkg: sshguard
  service.running:
    - enable: True
    - require:
      - pkg: sshguard
      - file: sshguard
    #- require_in:
    #  - file: /etc/ferm/ferm.conf
    - watch:
      - file: sshguard

/etc/sshguard/whitelist:
  file.managed:
    - require:
      - pkg: sshguard
    - watch_in:
      - service: sshguard
    - contents: |
        127.0.0.0/8
        #10.72.0.0/16
        #10.75.0.0/16
        ::1/128
