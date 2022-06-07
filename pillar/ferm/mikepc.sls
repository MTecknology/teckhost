ferm:
  additional_rules:
    inbound:
      # allow pulse connections
      - 'proto tcp dport 4713 saddr 10.41.2.202 ACCEPT'
      # allow ssh in local network
      - 'proto tcp dport ssh saddr 10.0.0.0/8 ACCEPT'
