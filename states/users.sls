ssh-user:
  group.present:
    - system: True

root:
  user.present:
    - shell: /bin/bash
    - home: /root
    - uid: 0
    - gid: 0
    - password: {{ pillar['root_pass'] }}
    - remove_groups: True
  file.absent:
    - name: /root/.ssh/authorized_keys

{% for user, attr in salt.pillar.get('users', {}).items() %}
{%- if user not in salt.pillar.get('device_users') %}
{{ user }}:
  file.missing:
    - name: /home/{{ user }}
  user.absent:
    - purge: True
  group.absent:
    - require:
      - user: {{ user }}
{% else %}

{{ user }}:
  group.present:
    - gid: {{ attr['ugid'] }}
  user.present:
    - shell: /bin/bash
    - home: /home/{{ user }}
    - uid: {{ attr['ugid'] }}
    - gid: {{ attr['ugid'] }}
    {% if 'pwd' in attr %}
    - password: {{ attr['pwd'] }}
    {% endif %}
    {% if 'groups' in attr %}
    - optional_groups:
      {% for group in attr['groups'] %}
      - {{ group }}
      {% endfor %}
      - users
      - cdrom
      - floppy
      - audio
      - dip
      - video
      - plugdev
      - netdev
      - bluetooth
      - scanner
    - remove_groups: False
    - require:
      - group: {{ user }}
      {% for group in attr['groups'] %}
      - group: {{ group }}
      {% endfor %}
    {% endif %}

/home/{{ user }}:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - dir_mode: "0700"
    - require:
      - user: {{ user }}

{% if 'keys' in attr %}
{{ user }}-ssh:
  ssh_auth.present:
    - user: {{ user }}
    - names: {{ attr['keys']|json }}
    - fingerprint_hash_type: md5
    - require:
      - user: {{ user }}
{% endif %}

{% endif %}{% endfor %}{# for user, attr #}
