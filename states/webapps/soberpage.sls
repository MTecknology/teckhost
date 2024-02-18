include:
  - nginx

soberpage:
  git.latest:
    - name: https://danwin1210.de:1443/recoverysource/sober.page
    - target: /srv/soberpage
    - force_checkout: True
  file.managed:
    - name: /etc/nginx/conf.d/soberpage.conf
    - source: salt://webapps/nginx-cfg/soberpage.conf
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx
  cmd.run:
    - name: /srv/soberpage/sync.py -n
    - watch:
      - git: soberpage
    - watch_in:
      - service: nginx
