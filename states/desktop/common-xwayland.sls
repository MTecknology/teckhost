common-X:
  pkg.installed:
    - pkgs:
      - dbus-x11
      - libx11-data
      - x11-apps
      - x11-session-utils
      - x11-xkb-utils
      - x11-xserver-utils
      - xserver-xorg-core
      - xserver-xorg-input-all
      - xwayland
      - kwayland-integration
      - firmware-misc-nonfree
      {% if salt.grains.get('lsb_distrib_release', 12)|int <= 11 %}
      - firmware-linux-nonfree
      {% endif %}
