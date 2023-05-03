#!jinja|yaml|gpg

users:
  michael:
    ugid: 1000
    groups:
      - ssh-user
      - sudo
    pwd: |
        -----BEGIN PGP MESSAGE-----

        hQIMA7+DShJS+9zMARAAjrDYPlj9/B0iHy0d7jfURIQhknAXZoWtXCd4ulSXZA/W
        G+iEXKQR2PRUKzBV9XBBngCWepL9b8BIPHlXJmL8LmUzbGGcmay7sV1j/Nc7vQ7D
        Z7AQi5ZwCzEnmpnwz9dLP1pM3rGWCEdvZvHMfBz37vbCT2xxtkivcR3B9xg+0eKV
        P3+BAX7iCw7gvzAr8Oipjmz6Y+H9GDAH50GEgC7yI0R+2scQ77mrAlk1wqi09csF
        i9sQIbyWElw7n5fcYAl/6ypWq8Y59Do7wNR24idPJxKyTS8BOzrrCmE4cHITuHUr
        jQus+j313NoKgnlLPeQ/Ahc0o8oVRHNpuhRaQrecX09U49acXyzMb3P3HJzpu+GN
        0l/yOuor9+QmerhmK+a7zVt1Z4RUtUhqldoECOhlUfsl0v20b2t3Yjtkjui5DqLn
        Zbn4YkHIXM3lnmSmQruOgjCKSS3e8cuSKqsST958/LC4OavqvLWw9H5RlxpZhZ2N
        ukHoEQT3WG85IsvOdKfodbQ/+Lq8HKNDupPULFubKU8sOZPVjmxaX8NHyQmG2yl6
        9Xx2iZgyTnPnyJozhKUeazSOFWg0tznrVcX4buird3RGjjM06NMMQ4KzYyaC7BJt
        C7f5Mi3PUSd5Kp3wjCQaI4W5ea6xT1LNrv/QZLuKdc/fiHAShntbcyu88p2ic37S
        hAFTgfXWawCaA/elSZAAjA/O76Oum6AoaFsplIiU4VJaPgQ97g7HE0P7zXCUWyFb
        Py+K9+jOeClePqDbL5RdCUdSs24CshiK7STho1aEP2Y3Cx2Y+yANQujm15r8GvPq
        rVqaJrLwhgwWCvsZlCxMBli/5qKWU1hbiCN7n1kn1WHQ0Bp2Fw==
        =9f03
        -----END PGP MESSAGE-----
    keys:
      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDUGwmFHLugs42aNZl10vttqSd5/TyuwlSIAeZ0FRLul michael@mikepc
    init: |
        -----BEGIN PGP MESSAGE-----

        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
        QnkBgw==
        =cmgb
        -----END PGP MESSAGE-----
    init_installif:
      - fun: match.glob
        tgt: 'mikepc*'
    init_installunless:
      - fun: file.directory_exists
        path: /home/michael/repos/data/.private
