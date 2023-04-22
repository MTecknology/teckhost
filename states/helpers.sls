# cmd.wait will do nothing until triggered (i.e. -watch_in:)

systemd-reload:
  cmd.wait:
    - name: systemctl daemon-reload

# Should typically prefer "- refresh: True"
apt-update:
  cmd.wait:
    - name: apt-get update
