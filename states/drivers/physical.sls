{% if not salt.environ.get('container', False) %}
include:
  - mokcert
  - nvidia
{% endif %}
