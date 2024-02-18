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
    - require:
      - pkg: nginx
    - watch:
      - git: soberpage
    - watch_in:
      - service: nginx
  cron.present:
    - name: "/srv/soberpage/sync.py -n && service nginx reload"
    - identifier: soberpge
    - minute: 30
    - hour: 0
    - require:
      - git: soberpage
