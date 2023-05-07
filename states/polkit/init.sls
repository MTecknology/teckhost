polkit:
  pkg.installed:
    - name: policykit-1
  file.recurse:
    - name: /etc/polkit-1/localauthority
    - source: salt://polkit/localauthority
    - exclude_pat: "*/.gitkeep"
    - include_empty: True
    - file_mode: '0640'
    - dir_mode: '0750'
    - clean: True
    - require:
      - pkg: polkit
  {% if not salt.chroot.in_chroot() %}
  service.running:
    - name: polkit
    - enable: True
    - require:
      - pkg: polkit
    - watch:
      - file: polkit
      - file: /etc/polkit-1/rules.d
  {% endif %}

/etc/polkit-1/rules.d:
  file.absent:
    - require:
      - pkg: polkit
