include:
  - basics
  - desktop.common-xwayland
  - desktop.common-apps

desktop-cinnamon:
  pkg.installed:
    - names:
      - apparmor
      - apparmor-utils
      - blueman
      - cinnamon-core
      - dconf-cli
      - eog
      - evince
      - firefox-esr
      - chromium
      - fonts-liberation
      - fonts-pc
      - fonts-recommended
      - fonts-ubuntu
      - gnome-calculator
      - gnome-screenshot
      - thunderbird
      - totem
      - vlc
      - cheese
      - cups
      - gimp
      - gnome-disk-utility
      - gnome-font-viewer
      - gnome-system-monitor
      - gnote
      - gstreamer1.0-libav
      - gstreamer1.0-plugins-ugly
      - inkscape
      - laptop-mode-tools
      - libreoffice-calc
      - libreoffice-gnome
      - libreoffice-impress
      - libreoffice-writer
      - mate-themes
      - orca
      - remmina
      - rhythmbox
      - seahorse
      - gnome-photos
      - simple-scan
      - sound-theme-freedesktop
      - system-config-printer
      - zenity
    - require:
      - pkg: common-X

desktop-cinnamon-trim:
  pkg.purged:
    - names:
      - apache2-bin
      - gnome-games
      - gnome-software-common
      - gnome-user-share
      - hexchat
      - hexchat-common
      - hexchat-plugins
      - transmission-gtk
      - transmission-common
    - require:
      - pkg: desktop-cinnamon

{% for managed in ['loginbg.jpg', 'defaultbg.jpg', 'lightdm.conf', 'lightdm-gtk-greeter.conf'] %}
/etc/lightdm/{{ managed }}:
  file.managed:
    - source: salt://desktop/{{ managed }}
    - require:
      - pkg: desktop-cinnamon
{% endfor %}

/etc/X11/default-display-manager:
  file.managed:
    - contents: '/usr/sbin/lightdm'

desktop-background:
  alternatives.install:
    - link: /usr/share/images/desktop-base/desktop-background
    - path: /etc/lightdm/defaultbg.jpg
    - priority: 100
