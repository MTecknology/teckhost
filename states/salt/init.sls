{% set version = salt.pillar.get('versions:salt-minion', '3006.4') %}
include:
  - helpers

# Clean up obsolete or accidental installations
salt-cleanup:
  pkg.purged:
    - names:
      - salt-minion
      - salt-master
      - salt-common

/etc/salt/pki/minion:
  file.directory:
    - dir_mode: '0750'
    - makedirs: True
    - require:
      - pkg: salt-cleanup
    - require_in:
      - cmd: salt-solo

/etc/salt/minion.d/teckhost.conf:
  file.managed:
    {% if salt.grains.get('bootstrap:devdir') and not salt.chroot.in_chroot() %}
    - source: salt://salt/saltlocal.conf
    {% else %}
    - source: salt://salt/saltsolo.conf
    {% endif %}
    - template: jinja
    - dir_mode: '0750'
    - makedirs: True
    - require:
      - pkg: salt-cleanup
    - require_in:
      - file: salt-solo

salt-solo:
  pkg.installed:
    - name: python3-venv
    - require:
      - pkg: salt-cleanup
  cmd.run:
    - name: 'python3 -m venv /opt/salt; /opt/salt/bin/pip3 install salt=={{ version }}'
    - unless: '/opt/salt/bin/salt --version | grep {{ version }}'
    - watch:
      - pkg: salt-solo
    - require:
      - pkg: salt-solo
  cron.present:
    - name: /opt/salt/bin/salt-call --local state.highstate
    - identifier: highstate
    - special: '@hourly'
    - require:
      - pkg: salt-solo

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
      - pkg: salt-solo
{% if not salt.chroot.in_chroot() %}
  mount.mounted:
    - name: {{ salt.grains.get('bootstrap:devdir') }}
    - device: devdir
    - fstype: vboxsf
    - require:
      - cmd: virtualbox-guest
    - require_in:
      - file: salt-solo
{% endif %}
{% endif %}
