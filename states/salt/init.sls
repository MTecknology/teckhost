salt-minion:
  pkg.installed: []
  file.managed:
    - name: /etc/salt/minion.d/teckhost.conf
    {% if salt.grains.get('bootstrap:devdir') and not salt.chroot.in_chroot() %}
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
  cron.present:
    - name: salt-call --local state.highstate
    - identifier: highstate@boot
    - special: '@reboot'
    - require:
      - pkg: salt-minion
{% if not salt.chroot.in_chroot() %}
  mount.mounted:
    - name: {{ salt.grains.get('bootstrap:devdir') }}
    - device: devdir
    - fstype: vboxsf
    - require:
      - cmd: virtualbox-guest
    - require_in:
      - file: salt-minion
{% endif %}
{% endif %}
