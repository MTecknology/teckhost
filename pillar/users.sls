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
    ugid: 7000
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
        uCUFhTbJEYk=
        =Vl3G
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
