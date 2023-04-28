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

# Hibernation is problematic with SecureBoot and (separately) disk encryption
/etc/systemd/sleep.conf:
  file.managed:
    - mode: '0644'
    - source: salt://nvidia/sleep.conf

/etc/modprobe.d/nvidia-kernel-common.conf:
  file.managed:
    - mode: '0644'
    - source: salt://nvidia/nvidia-kernel-common.conf

{% endif %}{# if nvidia[present] #}
