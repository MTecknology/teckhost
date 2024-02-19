include:
  - nginx

soberpage:
  git.latest:
    - name: https://danwin1210.de:1443/recoverysource/sober.page
    - target: /srv/webapps/soberpage
    - force_checkout: True
    - require:
      - file: /srv/webapps
  file.managed:
    - name: /etc/nginx/conf.d/soberpage.conf
    - source: salt://webapps/nginx-cfg/soberpage.conf
    - require:
      - pkg: nginx
    - onchanges_in:
      - service: nginx
  cmd.run:
    - name: "/srv/webapps/soberpage/sync -n -d /srv/webapps/soberpage/data/domains"
    - require:
      - pkg: nginx
      - git: soberpage
    - onchanges:
      - git: soberpage
    - onchanges_in:
      - service: nginx
  cron.present:
    - name: "/srv/webapps/soberpage/sync -n -d /srv/webapps/soberpage/data/domains && service nginx reload"
    - identifier: soberpge
    - minute: 30
    - hour: 0
    - require:
      - git: soberpage
