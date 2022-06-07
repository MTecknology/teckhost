# Include user-based extras
include:
  {% for user, attr in salt.pillar.get('users', {}).items() %}
  {% if attr.get('teckuser', False) %}
  - teckhost_users.{{ user }}
  {% endif %}
  {% endfor %}
