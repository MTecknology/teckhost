# Available Chromium Policies: https://chromeenterprise.google/policies/

policy-chromium-preferences:
  file.managed:
    - name: /etc/chromium/master_preferences
    - source: salt://user_policies/chromium/master_preferences
    - require:
      - pkg: desktop-cinnamon

/etc/chromium/policies:
  file.directory:
    - dir_mode: '0755'
    - require:
      - pkg: desktop-cinnamon

policy-chromium-managed:
  file.directory:
    - name: /etc/chromium/policies/managed
    - dir_mode: '0755'
    - require:
      - file: /etc/chromium/policies

policy-chromium-recommended:
  file.directory:
    - name: /etc/chromium/policies/recommended
    - dir_mode: '0755'
    - require:
      - file: /etc/chromium/policies

/etc/chromium/default_bookmarks.html:
  file.managed:
    - source: salt://user_policies/chromium/default_bookmarks.html
    - mode: '0644'
    - require:
      - file: /etc/chromium/policies

/etc/chromium/policies/managed/preferences.json:
  file.managed:
    - source: salt://user_policies/chromium/preferences.json
    - mode: '0644'
    - require:
      - file: policy-chromium-managed
