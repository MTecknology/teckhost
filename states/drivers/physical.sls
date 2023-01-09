include:
  - mokcert

{% set nvidia = {'present': False} %}
{% for gpu in salt.grains.get('gpus', []) %}
{% if gpu['vendor'] == 'nvidia' %}
{%   do nvidia.update({'present': True}) %}
{% endif %}{% endfor %}
# nvidia: {{ nvidia }}

{% if nvidia['present'] %}
nvidia:
  pkg.installed:
    - names:
      - nvidia-driver
      - nvidia-cuda-toolkit
      - nvidia-cuda-toolkit-gcc
      - nvidia-cudnn
    - require:
      - pkg: mokutil
{% endif %}
