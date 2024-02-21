include:
  - certbot
  - nginx

/etc/nginx/conf.d/ipecho.conf:
  file.managed:
    - source: salt://nginx/configs/ipecho.conf
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx
