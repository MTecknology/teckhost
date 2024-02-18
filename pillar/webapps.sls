webapps:
  {% if salt.match.glob('irc.lustfield.net') %}
  mtpaste: paste.lustfield.net
  ipecho: ip.lustfield.net
  {% elif salt.match.glob('*.sobersupport.group') %}
  soberpage: None  # monolithic
  {% endif %}
