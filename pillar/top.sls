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

  'irc*':
    - webapps
    - ferm.irc
