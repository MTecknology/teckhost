include:
  {% for webapp in salt.pillar.get('webapps', {}).keys() %}
  - .{{ webapp }}
  {% endfor %}
