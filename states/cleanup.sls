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
