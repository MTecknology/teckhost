# Random little things that are nice to clean up after a system is deployed.

/tmp/gpgpassphrase:
  file.absent: []

/tmp/bootstrap:
  file.absent: []

debconf-cleanup:
  debconf.set:
    - data:
        'netcfg/wireless_show_essids': {'type': 'select', 'value': ''}
        'netcfg/wireless_essid': {'type': 'string', 'value': ''}
        'netcfg/wireless_wpa': {'type': 'string', 'value': ''}
        'gpgpassphrase/ask': {'type': 'string', 'value': ''}

{# if salt.file.file_exists('/usr/sbin/lvm') and not salt.chroot.in_chroot() %}
# d-i requires this for math
preseed-lvm-scratch:
  lvm.lv_absent:
    - name: scratch
    - vgname: sys
{% endif #}
# Is this a bug in the lvm mod/fun?
# Is salt missing a mounted file system?
# + Can the removal be done manually during install from in-target?
