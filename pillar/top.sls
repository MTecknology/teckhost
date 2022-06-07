base:
  '*':
    - users.root
    - users.michael

  'patpc*':
    - users.patricia

  'mikepc*':
    - ferm.mikepc

  'irc*':
    - webapps
    - ferm.irc
