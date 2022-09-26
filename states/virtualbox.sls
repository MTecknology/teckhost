include:
  - apt.virtualbox

virtualbox:
  pkg.installed:
    - name: virtualbox-6.1
    - refresh: True
    - require:
      - file: apt-repo-virtualbox
