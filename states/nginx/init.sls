nginx:
  pkg.installed: []
  service.running:
    - reload: True
    - watch:
      - file: /etc/nginx/sites-enabled/default
      - file: /etc/nginx/conf.d/no-tokens.conf
      - file: /etc/nginx/conf.d/ssl-settings.conf

/srv/webapps:
  file.directory

/etc/nginx/conf.d/no-tokens.conf:
  file.managed:
    - contents: |
        server_tokens off;
    - require:
      - pkg: nginx

/etc/nginx/conf.d/ssl-settings.conf:
  file.managed:
    - contents: |
        ssl_session_cache shared:SSL:10m;
        ssl_session_timeout 10m;
        ssl_ciphers 'kEECDH+CHACHA kEECDH+AESGCM HIGH+kEECDH AESGCM 3DES !SRP !PSK !DSS !MD5 !LOW !MEDIUM !aNULL !eNULL !DH !kECDH';
        ssl_stapling on;
        ssl_stapling_verify on;
        #ssl_dhparam ssl/dhparam.pem;
        ssl_session_tickets off;
        ssl_protocols TLSv1.2;
    - require:
      - pkg: nginx

/etc/nginx/nginx.conf:
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://nginx/nginx.conf
    - watch_in:
      - service: nginx

/etc/nginx/sites-enabled/default:
  file.absent:
    - require:
      - pkg: nginx
