include:
  - nginx

cloudflare-api:
  pkg.installed:
    - name: python3-cloudflare
  file.managed:
    - name: /root/.cloudflare.cfg
    - contents: |
        [CloudFlare]
        token = {{ salt.pillar.get('cloudflare:token') }}
        zone = {{ salt.pillar.get('cloudflare:zone') }}
    - mode: '0600'
    - require:
      - pkg: cloudflare-api

soberpage:
  git.latest:
    - name: https://github.com/recoverysource/sober.page
    - target: /srv/webapps/soberpage
    - force_checkout: True
    - force_fetch: True
    - force_reset: True
    - require:
      - file: /srv/webapps
  file.symlink:
    - name: /etc/nginx/conf.d/soberpage.conf
    - target: /srv/webapps/soberpage/nginx.conf
    - require:
      - pkg: nginx
      - git: soberpage
    - watch_in:
      - service: nginx
  cmd.run:
    - name: "/srv/webapps/soberpage/sync -l WARNING -n -d /srv/webapps/soberpage/data/domains -r"
    - require:
      - pkg: nginx
      - git: soberpage
      - pkg: cloudflare-api
    - onchanges:
      - git: soberpage
    - watch_in:
      - service: nginx
  cron.present:
    - name: "/srv/webapps/soberpage/sync -l WARNING -n -d /srv/webapps/soberpage/data/domains -r && service nginx reload"
    - identifier: soberpge
    - minute: 30
    - hour: 0
    - require:
      - git: soberpage
      - pkg: cloudflare-api
