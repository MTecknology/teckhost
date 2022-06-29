mokutil:
  pkg.installed: []

mokcert:
  cmd.run:
    - name: 'openssl req -new -x509 -newkey rsa:2048 -keyout /root/MOK.priv -outform DER -out /root/MOK.der -nodes -days 36500 -subj "/CN=Teckhost/"'
    - unless: 'test -f /root/MOK.priv'
    - require:
      - pkg: mokutil

# NOTE: This will require the root password to enroll the cert at next boot
mokcert-register:
  cmd.run:
    - name: 'mokutil --root-pw --import /root/MOK.der'
    - unless: 'mokutil --list-enrolled | grep -q Teckhost'

{% for mod in ['vboxdrv'] %}
mokcert-sign-{{ mod }}:
  cmd.wait:
    - name: '/usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 /root/MOK.priv /root/MOK.der $(modinfo -n {{ mod }})'
    - unless: 'modinfo -F signer {{ mod }} | grep -q Teckhost'
    - require:
      - cmd: mokcert
{% endfor %}
