include:
  - apt.virtualbox

virtualbox:
  pkg.installed:
    - name: virtualbox
    - refresh: True
    - require:
      - file: apt-repo-virtualbox
