certbot:
  pkg.installed: []

certbot-issue-preflight:
  cmd.run:
    - name: "service nginx stop; true"

{% for webapp, domain in salt.pillar.get('webapps', {}).items() %}
certbot-issue-{{ webapp }}:
  cmd.run:
    - name: "certbot certonly --standalone --quiet --non-interactive --agree-tos --email michael@lustfield.net -d {{ domain }}"
    - unless: "test -d /etc/letsencrypt/live/{{ domain }}"
    - prereq_in:
      - cmd: certbot-issue-preflight
    - require_in:
      - service: nginx
    - require:
      - pkg: certbot
{% endfor %}
