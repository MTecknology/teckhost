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
  {%- elif salt.match.glob('blpc*') %}
  - becky
  - laura
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

        hQIMA7+DShJS+9zMAQ/+PUjGi6zVhu/BcYkeK9pSI/DZ1ee//yG+8JhUpD9EIj1b
        P52UG7cAF/Oss3rvzIoDrkUGc9W25xvnJ6wz7ut18zuHsVo5Lt9Sc0Fmti8a/CPf
        SiAzyTjOqPiENIovXA9kW1hxavqIyKyqpBGtI+XPK6dbqmI35C7GZVfNCO+NOS0D
        XhKl/pZTzrQE84FgFsgRx0aGGwOUocXlJslTPlwY0/78PxrO3Z5t71My9MSjEWs6
        ktG0KqBtWvTpHSGCEoJrxF9YSCtRH9Jm2FfikFaU59eoRk1HwkD/YnxcuEImLQ9T
        erw1Y8KDlGAlZ3vuvUtmPJxJEmp3es3p4P3sw9uuP4L/jYQHPcH28KHYh51VRW4P
        Gdjp3+9vy5AoYYo0HLBgA5SYwc1QzqTJthCkpP1pRUuBl+fh+JLMVkujDL90YEo9
        5k5suVNIfgknMiMNyBImlAif4w2GcEZJI21HPXq5wim5wJajaCqpNIc4yzf7NpeB
        duJ5tufVXgOupV7l3EXa++DJeISxHkrP89yOHJHt+NMNwSCWdngn1X9WkY24T1DR
        DXf7llo2y5/BIxyZ/0u6oB5/ePrX0UGeN4LLpFBIjhZrtBwrPSo+mjlDwYFBgV2x
        ceoFUmhv+A/a/b2W7f74MnP7qApVU4L5399Ow/VOWw+qNTj4FtezHTTDqhxSFQ3S
        hAE62KbW0Jfa21IdSmgrR4b77wS9TMGZah92rpkj5XQbgNdyPmEsKv7C0QzO6R50
        Zsk/UbJYgouUbORtfzBuImi2CGCpM7Ci4+I3hyHw6Tt7Wf499fQxXbIWjYeW5NY8
        3Bjwg0NrFO0N+EKICx4kr22ySYzcX7HY5cvFQQYDGsDEQssjGQ==
        =UPBq
        -----END PGP MESSAGE-----
    keys:
      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDUGwmFHLugs42aNZl10vttqSd5/TyuwlSIAeZ0FRLul michael@mikepc
    init: |
        -----BEGIN PGP MESSAGE-----

        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
        L+sHZ50L6NbFzg==
        =+ocb
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

  becky:
    ugid: 7004
    groups: []
    pwd: |
        -----BEGIN PGP MESSAGE-----

        hQIMA7+DShJS+9zMAQ//XUsW6H8tbj2/nXzA023mKzKI9y/6D3kSAQAity5MduGm
        o3mgbcXk36li4sqChch5dKIxa95CXA9+xe1y4COfbhD26v3eAa+pgK/uNt7JPEUw
        lanUQWkSqiz/aESDQctA1dNDuN9kDPCf9IfYT0hEAOE8DH0c2RzUmeY0FLHMxcyd
        0GmaroGWhzuubPujlziTENuaovi/uaWdvdp9CBJQnfP8aD+SuSVD6VQlHisjHA+0
        5wivf8wBbaPL+Amrt54PkUrvf9C/fP8nX4c2HaYyPkdTOcuMSDK6KUvj0kU2Mpjt
        QlL5xqsnk6QqSNpyNRfxfJk930psTVRjDAxlRuDi9BFhXcWsIdAKo9sJNyDH6WkP
        1Bdy+UNtmwEOkfybTOv2etndWFrr3GLpUueC++qRAAjK98j//CdlYPmdODi7AZKT
        kNzOP1JeZd5Spbx18UPPbsqEwPmUzTnKG3DcC8C8Ko5sMdICuPrWRTlDDnuA4fxk
        pbkBSQxOkvVUPZyZlFGsk6RjnIwmFWUc77pWKZ4mrTr268zxh9X9m/8REyfym1ip
        9VUlxZHsIJUKUkAnrgBbsI11NpNIon+646yzk6rErBuVWvJhTOP8UhWwz8Lib9di
        zoLmczuHesHjUPhwVOTx2hzgg2mRLsUkz/Tl9/wDnIKsoR6dU4oFcScJXXhngjHS
        RwGxvJgICTlStUxixXOvzd2W70ienXl2Gt75NFWkINU6mw5cv+F8JUiOb1tPE+v4
        yaWmIdzLzw5U+LPOZyOzWECbkqq7Sq5f
        =9EaV
        -----END PGP MESSAGE-----

  laura:
    ugid: 7005
    groups: []
    pwd: |
        -----BEGIN PGP MESSAGE-----

        hQIMA7+DShJS+9zMAQ//XUsW6H8tbj2/nXzA023mKzKI9y/6D3kSAQAity5MduGm
        o3mgbcXk36li4sqChch5dKIxa95CXA9+xe1y4COfbhD26v3eAa+pgK/uNt7JPEUw
        lanUQWkSqiz/aESDQctA1dNDuN9kDPCf9IfYT0hEAOE8DH0c2RzUmeY0FLHMxcyd
        0GmaroGWhzuubPujlziTENuaovi/uaWdvdp9CBJQnfP8aD+SuSVD6VQlHisjHA+0
        5wivf8wBbaPL+Amrt54PkUrvf9C/fP8nX4c2HaYyPkdTOcuMSDK6KUvj0kU2Mpjt
        QlL5xqsnk6QqSNpyNRfxfJk930psTVRjDAxlRuDi9BFhXcWsIdAKo9sJNyDH6WkP
        1Bdy+UNtmwEOkfybTOv2etndWFrr3GLpUueC++qRAAjK98j//CdlYPmdODi7AZKT
        kNzOP1JeZd5Spbx18UPPbsqEwPmUzTnKG3DcC8C8Ko5sMdICuPrWRTlDDnuA4fxk
        pbkBSQxOkvVUPZyZlFGsk6RjnIwmFWUc77pWKZ4mrTr268zxh9X9m/8REyfym1ip
        9VUlxZHsIJUKUkAnrgBbsI11NpNIon+646yzk6rErBuVWvJhTOP8UhWwz8Lib9di
        zoLmczuHesHjUPhwVOTx2hzgg2mRLsUkz/Tl9/wDnIKsoR6dU4oFcScJXXhngjHS
        RwGxvJgICTlStUxixXOvzd2W70ienXl2Gt75NFWkINU6mw5cv+F8JUiOb1tPE+v4
        yaWmIdzLzw5U+LPOZyOzWECbkqq7Sq5f
        =9EaV
        -----END PGP MESSAGE-----
