/etc/dconf/profile:
  file.recurse:
    - source: salt://user_policies/cinnamon/profile
    - clean: True
    - require:
      - pkg: desktop-cinnamon

/etc/dconf/db/mtpol.d:
  file.recurse:
    - source: salt://user_policies/cinnamon/mtpol
    - clean: True
    - require:
      - pkg: desktop-cinnamon

dconf-update:
  cmd.run:
    - name: dconf update
    - onchanges:
      - file: /etc/dconf/profile
      - file: /etc/dconf/db/mtpol.d
