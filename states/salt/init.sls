/etc/salt/minion.d/saltsolo.conf:
  file.absent: []

/etc/salt/minion.d/saltlocal.conf:
  file.absent: []

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

{% if salt.grains.get('bootstrap:devdir') and not salt.chroot.in_chroot() %}
##
# Mount devdir (Development Directory) for local development
##

#TODO :: BREAKPOINT :: First, get the VM to boot to this point, then move on ...
#vbox-extras:
#  pkg.installed:
#    - name: linux-headers-$(uname -r) vbox-add-iso #FIXME
#  cmd.wait:
#    unpack; build; load ??
#  modprob.present: #FIXME
#    - name: ??
#
#devdir:
#  #mount -t vboxsf [-o OPTIONS] sharename mountpoint
{% endif %}
