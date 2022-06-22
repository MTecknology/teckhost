salt-minion:
  pkg.installed: []
  file.managed:
    - name: /etc/salt/minion.d/teckhost.conf
    {% if salt.grains.get('bootstrap:devdir') %}
    - source: salt://salt/saltlocal.conf
    {% else %}
    - source: salt://salt/saltsolo.conf
    {% endif %}
    - template: jinja
    - require:
      - pkg: salt-minion

salt-solo:
  service.dead:
    - name: salt-minion
    - enable: False
    - require:
      - pkg: salt-minion
  cron.present:
    - name: salt-call --local state.highstate
    - identifier: highstate
    - special: '@hourly'
    - require:
      - pkg: salt-minion

{% if salt.grains.get('bootstrap:devdir') %}
##
# Mount devdir (Development Directory) for local development
##
salt-devdir:
  pkg.installed:
    - names:
      - virtualbox-guest-utils
  mount.mounted:
    - name: {{ salt.grains.get('bootstrap:devdir') }}
    - device: devdir
    - fstype: vboxsf
    - require:
      - pkg: salt-devdir
    - require_in:
      - file: salt-minion
{% endif %}
