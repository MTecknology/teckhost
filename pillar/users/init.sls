include:
  - .root
  - .michael
  {%- if salt.match.glob('patpc*') %}
  - .patricia
  {%- elif salt.match.glob('dgpc*') %}
  - .gene
  - .filisha
  {%- elif salt.match.glob('filipc*') %}
  - .filisha
  {%- endif %}
