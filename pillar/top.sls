base:
  '*':
    - pcsupport
    - security
    - users.root
    - users.michael

  'patpc*':
    - users.patricia

  'mikepc*':
    - ferm.mikepc

  'dgpc*':
    - users.gene
    - users.filisha

  'filipc*':
    - users.filisha

  'irc*':
    - webapps
    - ferm.irc
