# Available Firefox Policies: https://github.com/mozilla/policy-templates/blob/master/README.md

policy-firefox-preferences:
  file.managed:
    - name: /etc/firefox-esr/firefox-esr.js
    - source: salt://user_policies/firefox/firefox-esr.js
    - require:
      - pkg: desktop-cinnamon

/etc/firefox/policies:
  file.directory:
    - makedirs: True
    - require:
      - pkg: desktop-cinnamon

policy-firefox-policies:
  file.managed:
    - name: /etc/firefox/policies/policies.json
    - source: salt://user_policies/firefox/policies.json
    - require:
      - file: /etc/firefox/policies
