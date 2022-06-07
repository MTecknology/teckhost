include:
  - certbot
  - nginx

/etc/nginx/conf.d/mtpaste.conf:
  file.managed:
    - source: salt://webapps/nginx-cfg/mtpaste.conf
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx

/srv/webapps/mtpaste:
  file.directory:
    - user: michael
    - group: michael
    - require:
      - user: michael
