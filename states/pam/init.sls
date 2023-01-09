pam:
  pkg.installed:
    - name: libpam-runtime

{% for config in [
    'common-account',
    'common-auth',
    'common-password',
    'common-session',
    'common-session-noninteractive',
    'cron',
    'lightdm',
    'login',
    'passwd',
    'sshd',
    'sudo',
    'su',
    'su-l'
    ] %}
/etc/pam.d/{{ config }}:
  file.managed:
    - source: salt://pam/{{ config }}
    - template: jinja
    - require:
      - pkg: pam
{% endfor %}
