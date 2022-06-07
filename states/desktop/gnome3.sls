include:
  - desktop.common-xwayland
  - desktop.common-apps

desktop-gnome3:
  pkg.installed:
    - names:
      - gnome
      - gnome-core
      - gnome-shell-extension-top-icons-plus
      - network-manager-gnome
      - pinentry-gnome3
      - task-gnome-desktop
    - require:
      - pkg: common-X
