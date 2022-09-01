base_pkgs:
  pkg.installed:
    - names:
      - apt-transport-https
      - build-essential
      - console-setup
      - file
      - git
      - gnupg
      - lsof
      - net-tools
      - openssh-client
      - rsync
      - screen
      - vim
    - require:
      - file: /etc/apt/sources.list

base_pkgs_removed:
  pkg.purged:
    - pkgs:
      - apt-listchanges
      - nano
      - vim-tiny

systemd-reload:
  cmd.wait:
    - name: systemctl daemon-reload

vim-sanity:
  file.managed:
    - name: /etc/vim/vimrc.local
    - require:
      - pkg: base_pkgs
    - contents: |
        let skip_defaults_vim=1
        syntax on
        set mouse=
        set background=dark
        filetype plugin indent on
