#include:
#  - sshguard

ssh:
  pkg.installed:
    - name: openssh-server
  service.running:
    - enable: True
    - require:
      - pkg: ssh
    - watch:
      - file: /etc/ssh/sshd_config

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://ssh/sshd_config
