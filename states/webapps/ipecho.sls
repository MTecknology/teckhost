include:
  - certbot
  - nginx

/etc/nginx/conf.d/ipecho.conf:
  file.managed:
    - source: salt://webapps/nginx-cfg/ipecho.conf
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx
