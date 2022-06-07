ferm:
  additional_rules:
    inbound:
      # allow SSH connections
      - 'proto tcp dport ssh ACCEPT'
      # allow web connections
      - 'proto tcp dport (http https) ACCEPT'
