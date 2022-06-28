##
# Extra Packages
##

teckhost-michael-extras:
  pkg.installed:
    - names:
      - vim
      # Laptop Extras
      {% if salt.match.glob('mikepc*') %}
      - claws-mail
      - claws-mail-multi-notifier
      - pylint3
      - python3-pudb
      - python3-flake8
      - python3-pytest
      - python3-testinfra
      - syslinux
      - isolinux
      - texlive-latex-base
      - texlive-latex-recommended
      - vagrant
      - xorriso
      #- virtualbox # TODO: This is pending unstable->stable
      {% endif %}

##
# Extra Partitioning
##
{% if salt.match.glob('mikepc*') and not salt.chroot.in_chroot() %}

overflow:
  lvm.lv_present:
    - vgname: sys
    - size: 150G
    - force: True
  blockdev.formatted:
    - name: /dev/mapper/sys-overflow
    - fs_type: xfs
    - require:
      - lvm: overflow
  mount.mounted:
    - name: /srv/overflow
    - device: /dev/mapper/sys-overflow
    - mkmnt: True
    - fstype: xfs
    - dump: 0
    - pass_num: 2
    - persist: True
    - require:
      - blockdev: overflow

{% for link, target in [
    ('.steam', '/srv/overflow/steam'),
    ('.vbox', '/srv/overflow/vbox'),
    ] %}
{{ target }}:
  file.directory:
    - user: michael
    - group: michael
    - require:
      - user: michael
      - mount: overflow

/home/michael/{{ link }}:
  file.symlink:
    - target: {{ target }}
    - force: True
    - user: michael
    - group: michael
    - require:
      - user: michael
{% endfor %}

{% endif %}

##
# Symlinks / Directories
##

{% for d in [
    'repos',
    '.config',
    '.vim',
    '.vim/tmp',
    '.vim/tmp/backup',
    '.vim/tmp/swap',
    '.vim/tmp/undo',
    ] %}
/home/michael/{{ d }}:
  file.directory:
    - user: michael
    - group: michael
    - require:
      - user: michael
{% endfor %}

/home/michael/.ssh:
  file.directory:
    - user: michael
    - group: michael
    - mode: "0700"
    - require:
      - user: michael

/home/michael/.gnupg:
  file.directory:
    - user: michael
    - group: michael
    - mode: "0700"
    - require:
      - user: michael

{% for link, target in [
    ('.config/autostart', 'repos/data/.homedir/.config/autostart'),
    ('.config/autostart-scripts', 'repos/data/.homedir/.config/autostart-scripts/'),
    ('.config/compiz', 'repos/data/.homedir/.config/compiz'),
    ('.config/keepassxc', 'repos/data/.homedir/.config/keepassxc/'),
    ('.config/mate-menu', 'repos/data/.homedir/.config/mate-menu/'),
    ('.config/openbox', 'repos/data/.homedir/.config/openbox/'),
    ('.config/terminator', 'repos/data/.homedir/.config/terminator/'),
    ('.bash_aliases', 'repos/data/.homedir/.bash_aliases'),
    ('.bash_logout', 'repos/data/.homedir/.bash_logout'),
    ('.bashrc', 'repos/data/.homedir/.bashrc'),
    ('.bin', 'repos/data/.private/.bin'),
    ('.crypt', 'repos/data/.private/.crypt'),
    ('.dput.cf', 'repos/data/.homedir/.dput.cf'),
    ('.gbp.conf', 'repos/data/.homedir/.gbp.conf'),
    ('.gnupg/gpg.conf', 'repos/data/.private/.gnupg/gpg.conf'),
    ('.gitconfig', 'repos/data/.homedir/.gitconfig'),
    ('.pass.kdbx', 'crypt/mnt/vault/pass.kdbx'),
    ('.pbuilderrc', 'repos/data/.homedir/.pbuilderrc'),
    ('.profile', 'repos/data/.homedir/.profile'),
    ('.quiltrc', 'repos/data/.homedir/.quiltrc'),
    ('.sbuildrc', 'repos/data/.homedir/.sbuildrc'),
    ('.screenrc', 'repos/data/.homedir/.screenrc'),
    ('.ssh/config', '.crypt/mnt/vault/ssh/config'),
    ('.ssh/id_ed25519', '.crypt/mnt/vault/ssh/id_ed25519'),
    ('.ssh/id_ed25519.pub', '.crypt/mnt/vault/ssh/id_ed25519.pub'),
    ('.signature', 'repos/data/.homedir/.signature'),
    ('.vimrc', 'repos/data/.homedir/.vimrc'),
    ('.vim/ftdetect', 'repos/data/.homedir/.vim/ftdetect'),
    ('.vim/ftplugin', 'repos/data/.homedir/.vim/ftplugin'),
    ('.vim/salt-vim.spec', 'repos/data/.homedir/.vim/salt-vim.spec'),
    ('.vim/spell', 'repos/data/.homedir/.vim/spell'),
    ('.vim/syntax', 'repos/data/.homedir/.vim/syntax'),
    ('.wallpaper.png', 'repos/data/.homedir/.wallpaper.png'),
    ] %}
/home/michael/{{ link }}:
  file.symlink:
    - target: /home/michael/{{ target }}
    - force: True
    - user: michael
    - group: michael
    - require:
      - user: michael
{% endfor %}

{% if salt.match.glob('irc.lustfield.net') %}
/home/michael/p:
  file.symlink:
    - target: /srv/webapps/mtpaste
    - user: michael
    - group: michael
    - require:
      - user: michael
{% endif %}


##
# Repositories
##

homedata:
  git.cloned:
    - name: https://github.com/MTecknology/homedata.git
    - target: /home/michael/repos/data
    - user: michael
    - require:
      - file: /home/michael/repos

##
# Misc.
##

/etc/cups/printers.conf:
  file.managed:
    - contents_pillar: teckhost_extra:printers_config
    - user: root
    - group: lp
    - mode: 0600
    - unless:
      - fun: file.file_exists
        path: /etc/cups/printers.conf
