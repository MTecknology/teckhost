{% if salt.match.glob('*pc*') %}
include:
  - .mountpoints
{% endif %}

/etc/security/access.conf:
  file.managed:
    - source: salt://security/access.conf
    - template: jinja

/etc/security/limits.conf:
  file.managed:
    - source: salt://security/limits.conf
    - template: jinja

/etc/modprobe.d/teckhost.conf:
  file.managed:
    - source: salt://security/modprobe.conf
    - template: jinja

/etc/sysctl.d/teckhost.conf:
  file.managed:
    - source: salt://security/sysctl.conf
    - template: jinja
