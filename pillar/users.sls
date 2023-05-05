#!jinja|yaml|gpg

device_users:
  - michael
  {%- if salt.match.glob('patpc*') %}
  - patricia
  {%- elif salt.match.glob('dgpc*') %}
  - gene
  - filisha
  {%- elif salt.match.glob('filipc*') %}
  - filisha
  {%- endif %}


root_pass: |
    -----BEGIN PGP MESSAGE-----

    hQIMA7+DShJS+9zMAQ//QuuhJBEKSWkzO3IIL8tJfMFD/Dl19mDmPCGWuocpemH9
    XL95j/ZzEEG5XYDHtkVt9dtWWSuv47j71hXP/p6R+S1yMI2vY09wTIRbHIUwkDBc
    DqnjwqR+Ijq2tot98KXrtJCsZMmO2MmC811V9UCs1zl6pyX6nt9nWGasq/5EvA7e
    hIaE3UlytWjjqScu9OQgAW/b4i0VsfAfIJa/QroZy6VMgnXdF+WH7wlxm3LtzkPv
    WCtHFHptuOTu38B08KaKh49uCPg5SYvmtvDA/A0bERsS2HJlRMzUvAR6a1Dtg9AG
    kaMQcA8Ac5qsmWp9ipBdLNF4gCdOxTJwNj6iKLNhh7EGAgga8yL2OcEnpOJyTkex
    E/x765tlRGrlOoNKJwM7bqp1CdUe4kifOv4fH/yH+mvIyRydLiMUryNyTyCsyWnv
    BO+9b0eJW1h+oCX17chcWE0dXlm4euHQfx5ccCYnKAnXgvzr6qeKYdoyftEU9/bY
    Fgv0wqND6ZQNTu+Q6x+USdtdK85AtD4sNZ5rG2NhEuC3j/2hdp+KmDE3UhXPeW0r
    CaTZYFnIfgcH0XbzSteELLk7EWJaaSrdRYczIy0/2zia/zdjzihg2SBSzCkWepKW
    caMDBE2ZVvx8P5GH5100rAfKu9CmHvKJNBEhfexojJYETnDCWsZRb8N/lQrSeTjS
    hAG1HP7Omd6nXb2I9zQgKglqNLLWgpwJ2c8P9RVpRYRwjvzeQCehEXoV4uFKsEuc
    1+Mm5LD+0wA/KDFLAqT7qFuelwDWtCa+Kc104Lcsi+pRYxrCW11B26dL9zSSo6gH
    k1/RaTSmuC9ZQH120Q26LetSz4U4XP65OJnYfCOx4b3OnydygA==
    =z0wh
    -----END PGP MESSAGE-----


users:

  michael:
    ugid: 1000
    groups:
      {% if not salt.match.glob('mikepc*') %}
      - ssh-user
      {% endif %}
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

  patricia:
    ugid: 7001
    groups: []
    pwd: |
        -----BEGIN PGP MESSAGE-----

        hQIMA7+DShJS+9zMAQ//baCRSQaFE9Y4kdaQMJkeWERQBomRZq8WE00OpBRy7Jai
        R3f4hldMX10AAw/mWvOCKTDbaYKLtdB9hi19z/dx/RVPdPYRxJmhqwqyyZ2Ak63k
        XIGCJiEB4JmbVmNhuIBl3V4i8N92p4K4fsCju7IWG2F5l2pO2uCRm8E8MwOiKX3C
        +tnQWGD0thdKjdZM+nYRWObVsWN4wyiOxeMUSxN4mowW94nm8C1WJPGp+xDHZ8RD
        qPgB4eRJaBYefXQE2DizBOrTJ02jpa4jeHn6zOOWyeUPHS+KBi7JVy3QmGmq87PY
        dtjpOV9rwFcd8Lg7O0tBQ9CPpE+SkAnr+zt/kKBjt90HGtqtXrgNP//M3UVSwZiG
        PhgXZecWgm8hwJUDpvPCcvFhFRO7Zaq+7gWAvRk4h9ZlWg8NI2ZH3xNPy+HStJRU
        hvPVbhDdeE4n79vHekOqLvmTSvqatrbWZ+NSYLG+PEBsA/O3Rv6QkonWhZyXctdv
        eIybhfp+hudKGphgeqieW/Wdr0jz6DYqcka33Lyy0UD9MwUmhgFVl7F9GLbwmZpM
        sLXRA+bdnBdJR7YRxPs6Wg0XbpqafG1u/Jl12dckEI2OWW12oDahmhfsA0ns2Rd5
        RK/+GggCGjvDayGJHOhz4InxlIWTOx+lXvkAU1WGpy5erYykhAIgg8dfEO04XmjS
        hAHlOP6k2hoQZyPapmO1/pVc9Uu10HWQ9T0TAFaZEDriNBeLwW4JjtF9Q+Omg7Jl
        yr7sNTaVWuO9Z+72j+0zOQs7xzOoo+3EPZZm36E20D8MDkJ1U+H3V7yB5B0fAQ0m
        aWPteewj2RhaNscukrklG8QdJLt7w9yUKkxe/PsW//UUNRhPmg==
        =OKrn
        -----END PGP MESSAGE-----

  gene:
    ugid: 7002
    groups: []
    pwd: |
        -----BEGIN PGP MESSAGE-----

        hQIMA7+DShJS+9zMAQ//T1xYSS8/MJma3UMZxEnMuNd1rDUCp5do55Me/rAgDWOs
        YRObUOKqXN+hFcrMbXVFJUPtKf218mOd7xt0OmhJmQvRAqJXTElPDlJ8XO2L1gcG
        cyaj6YoA8tNhOsrWTNqUnH2OdysRG9kK4PPNWbIaQPdOq3capoOFbhlLkKlTV0w0
        awexiA+d5o6aJnfqjpIkdqTQDlAezcZSIbDmFag2A6u/zlRhMj0DY42dk8/dkwX7
        oELPIFNtNRlWElSMw5hL0nmkQVTeLoeG6nrJzXoMW5WZJeRQLV6ZF46/+a0TcCkc
        OY/6kVAQfv0qqh/dZ77d3+OMF5+huKSuk8naNlNCpK7I5Z14Y7ZS8Q/SvkUX/Aof
        jaUF5MRJIir5h+KRxqdT1k7qGXwdndIMbAJpBiNrT7c6BGBbh7r7O9dPbgy+dxmK
        7aYP2rhhPs6sQNWj1fS4P22SPiGAXmOEbWPxnn6bd3gWg3Pk8oOtHy787cmdpbfS
        MU4iwVjToITFb48ccXLRlwqSzJw3UwG5cRbBgiGDKu+08soGBiwWx1p8ZZ+M5m9+
        nYIBjPuFWKlYsz5Es6Atv51+MZPf/IMZjOk1OLLXfXN5x3m9tuUD2DHcVPRqSh3a
        tR4UhilJiECR0WBfVm7Xkw/D2n3Vt6HXALCH8vW5gMt7ZtxpwLaQXuDbiBuze9LS
        hQGsM0cPvOPJjAgO9Ih3q6qM+pGizohlq6OK8yL2BR0hrvV9RLfJori4O5Ygd4yH
        Mltv0LlBv/qlLwy7JRCBIs68C+x3PS1o1hWvUYjsZCOd+DidGRHxRKUDCYwHoQHy
        K4HDFu/0b0z1iF/+fbbFTVYuH/WxGFijc7g23OmZNXGMfMTkzNs=
        =eakG
        -----END PGP MESSAGE-----

  filisha:
    ugid: 7003
    groups: []
    pwd: |
        -----BEGIN PGP MESSAGE-----

        hQIMA7+DShJS+9zMAQ/9EQQmG25cLxvgauwatvJwQbs7jOh1TePXeje4R+oBGQc0
        ZjVjBVJxq4XVpbcaRJYiQuHkxz6A6eVD1/vq4UQmQSXeQvfVjEH6tv+2jn2lWSFO
        MCFlL8o8q5F7Ak6ZBxP2BNZUw0L8okFpLs/HYtUCeWgk0jLTkwM8X1FhKBs7v3a7
        OW6954rc7v3Ux5MP0htuF2lkSDvv2HY/wVwWrhEcYkUUTY2RTzWf7lib2FQMDunu
        Y05uYXBRol41iUIg8ATss1z7C4/TOQ2zWg8CICmlnvEFG/JHxt5VxsZDoImqctJK
        hlW7+V8dypD36QTnK7cOFA5+TOqa7hKMfP0I9V7dAMDM0/fnvG95MOKHrBRlHBZ6
        AQfd0v8cPd/U7JoLXuSitn53aYm41es9xB7yq0WY/lXJ6Q91IdyVcF5syw26xlEq
        5bDgrutQ2SqeZg4Ojv/CejPW0FznrJyf3s/JPULN5SC0MolHwEdrq0zIWeuOVB6z
        9pfZp41DQXEGsEdy/7Gfzh3QSudf2scx5u2hE+gVDUblYzXCMg+FTHVNMJsRA63s
        6f8VZlASWa+aEdGmAiWWpxu5aK8822/KD8wNmgbj3Hs+SlitQbe9jCH7Rv1IWJng
        bs8QeiwFXhMF0Oly3nwnG4O3fH5W5kCmBzvBzrYLzFk+g1j7/Jrjx15hTB2HR6HS
        pQFJvQYMADelJBYXRYlmz9NqnUv7LYgxhA5W7ibWhbQ91IpxGtUKKOXFm2UWawRY
        xeFqzRXZqeLP1P0YrHD9fM3ff+ye/AR5D+qmtpe/gTk9rNm2e/62ObG1LUNtENFP
        4KG8MT9ccDS+Wt7XR75wCyJiVftSIe2pSkEYpTrDnPJkQ519GDFKJp4HfUaujfDk
        qqlblJ3vwYMrz6Ip0b94PnylkJzfWw==
        =ByC7
        -----END PGP MESSAGE-----
