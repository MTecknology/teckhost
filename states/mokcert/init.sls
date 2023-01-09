mokutil:
  pkg.installed:
    - names:
      - mokutil
      - dkms

/etc/dkms/framework.conf:
  file.managed:
    - source: salt://mokcert/framework.conf
    - mode: '0644'
    - require:
      - pkg: mokutil

/etc/dkms/sign_helper.sh:
  file.managed:
    - source: salt://mokcert/sign_helper.sh
    - mode: '0755'
    - require:
      - pkg: mokutil

mokcert:
  file.directory:
    - name: /root/.mok
    - dir_mode: '0700'
  cmd.run:
    - name: 'openssl req -config /root/.mok/openssl.cnf -new -x509 -newkey rsa:2048 -keyout /root/.mok/client.priv -outform DER -out /root/.mok/client.der -nodes -days 36500 -subj "/CN=Teckhost/"'  # noqa: 204
    - unless: 'test -f /root/.mok/client.priv'
    - require:
      - pkg: mokutil
      - file: mokcert
      - file: mokcert-sslconf

mokcert-sslconf:
  file.managed:
    - name: /root/.mok/openssl.cnf
    - source: salt://mokcert/openssl.cnf
    - require:
      - file: mokcert

# Provides a link for the "default" location in /etc/dkms/sign_helper.sh
{% for suffix in ['priv', 'der'] %}
/root/mok.{{ suffix }}:
  file.symlink:
    - target: /root/.mok/client.{{ suffix }}
    - require:
      - cmd: mokcert
{% endfor %}

mokcert-enroll:
  cmd.run:
    - name: 'mokutil --timeout 800; mokutil --import /root/.mok/client.der'
    - stdin: 'GR3en\nGR3en\n'
    - unless: '! mokutil --test-key /root/.mok/client.der'