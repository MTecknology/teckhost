{% if salt.grains.get('virtual', 'none').lower() in ['physical', 'virtualbox'] %}
include:
  - .{{ salt.grains.get('virtual').lower() }}
{% endif %}
