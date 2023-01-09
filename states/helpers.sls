# cmd.wait will do nothing until triggered as a dependency
systemd-reload:
  cmd.wait:
    - name: systemctl daemon-reload

apt-update:
  cmd.wait:
    - name: apt-get update
