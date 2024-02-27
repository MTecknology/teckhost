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
    - name: 'openssl req -config /root/.mok/openssl.cnf -new -x509 -newkey rsa:2048 -keyout /root/.mok/client.key -outform DER -out /root/.mok/client.der -nodes -days 36500 -subj "/CN=Teckhost/"'    # noqa: 204
    - unless: 'test -f /root/.mok/client.key'
    - require:
      - pkg: mokutil
      - file: mokcert
      - file: mokcert-sslconf

mokcert-pem:
  cmd.run:
    - name: 'openssl x509 -inform DER -in /root/.mok/client.der -outform PEM -out /root/.mok/client.pem'
    - onchanges:
      - cmd: mokcert

mokcert-sslconf:
  file.managed:
    - name: /root/.mok/openssl.cnf
    - source: salt://mokcert/openssl.cnf

mokcert-enroll:
  cmd.run:
    - name: 'mokutil --timeout 0; mokutil --import /root/.mok/client.der'
    - stdin: 'GR3en\nGR3en\n'
    - unless: 'mokutil --test-key /root/.mok/client.der | grep -q "already enrolled"'
    - require:
      - cmd: mokcert

mokcert-cleanup:
  file.managed:
    - name: /root/.mok/delete_oldmok
    - source: salt://mokcert/delete_oldmok.sh
    - mode: '0700'
    - require:
      - file: mokcert
      - file: /usr/local/lib/shell
  cmd.run:
    - name: /root/.mok/delete_oldmok
    - stateful: True
    - cwd: /root/.mok
    - require:
      - file: mokcert-cleanup
      - cmd: mokcert
