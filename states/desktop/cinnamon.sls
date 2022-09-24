include:
  - desktop.common-xwayland
  - desktop.common-apps

desktop-cinnamon:
  pkg.installed:
    - names:
      - cinnamon-desktop-environment
      - dconf-editor
    - require:
      - pkg: common-X
