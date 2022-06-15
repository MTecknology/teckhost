# Include user-based extras
{% for user, attr in salt.pillar.get('users', {}).items() %}
{% if attr.get('teckuser', False) %}
{% include 'teckhost_users/' ~ user ~ '.sls' ignore missing with context %}
{% endif %}
{% endfor %}
