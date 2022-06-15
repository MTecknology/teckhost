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
      {% if attr.get('teckuser', False) %}
      - cdrom
      - floppy
      - audio
      - dip
      - video
      - plugdev
      - netdev
      - bluetooth
      - scanner
      {% endif %}
    - remove_groups: False
    - require:
      - group: {{ user }}
      {% for group in attr['groups'] %}
      - group: {{ group }}
      {% endfor %}
    {% endif %}

{% if 'keys' in attr %}
{{ user }}-ssh:
  ssh_auth.present:
    - user: {{ user }}
    - names: {{ attr['keys']|json }}
    - fingerprint_hash_type: md5
    - require:
      - group: {{ user }}
{% endif %}

{% if attr.get('teckuser', False) %}
{% if 'init' in attr %}
/home/{{ user }}/firstlogin:
  file.managed:
    - contents_pillar: users:{{ user }}:init
    - user: {{ user }}
    - group: {{ user }}
    - mode: "0750"
    {% if 'init_unless' in attr %}
    - unless: {{ attr['init_unless']|json }}
    {% endif %}
{% endif %}{% endif %}

{% endfor %}
