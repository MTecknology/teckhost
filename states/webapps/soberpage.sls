include:
  - nginx

cloudflare-api:
  file.managed:
    - name: /root/.cloudflare.cfg
    - contents: TODO
  pkg.installed:
    - name: python3-cloudflare

soberpage:
  git.latest:
    - name: https://danwin1210.de:1443/recoverysource/sober.page
    - target: /srv/webapps/soberpage
    - force_checkout: True
    - require:
      - file: /srv/webapps
  file.managed:
    - name: /etc/nginx/conf.d/soberpage.conf
    - source: salt://nginx/configs/soberpage.conf
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx
  cmd.run:
    - name: "/srv/webapps/soberpage/sync -n -d /srv/webapps/soberpage/data/domains"
    - require:
      - pkg: nginx
      - git: soberpage
      - pkg: cloudflare-api
      - file: cloudflare-api
    - onchanges:
      - git: soberpage
    - watch_in:
      - service: nginx
  cron.present:
    - name: "/srv/webapps/soberpage/sync -n -d /srv/webapps/soberpage/data/domains && service nginx reload"
    - identifier: soberpge
    - minute: 30
    - hour: 0
    - require:
      - git: soberpage
      - pkg: cloudflare-api
      - file: cloudflare-api
