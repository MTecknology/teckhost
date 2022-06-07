salt-minion:
  pkg.installed: []
  file.managed:
    - name: /etc/salt/minion.d/saltsolo.conf
    - source: salt://salt/saltsolo.conf
    - template: jinja
    - require:
      - pkg: salt-minion

salt-solo:
  service.dead:
    - name: salt-minion
    - require:
      - pkg: salt-minion
  cron.present:
    - name: salt-call --local state.highstate
    - identifier: highstate
    - special: '@hourly'
    - require:
      - pkg: salt-minion
