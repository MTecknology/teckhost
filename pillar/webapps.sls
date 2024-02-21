#!jinja|yaml|gpg

webapps:
  {% if salt.match.glob('irc.lustfield.net') %}
  mtpaste: paste.lustfield.net
  ipecho: ip.lustfield.net
  {% elif salt.match.glob('*.sobersupport.group') %}
  soberpage: None  # monolithic
  {% endif %}

##
# App Tokens
##

{% if salt.match.glob('*.sobersupport.group') %}
cloudflare:
  token: |
      -----BEGIN PGP MESSAGE-----

      hQIMA7+DShJS+9zMAQ/9EHVMrFGifOf4D/6TZl6FR1oFb0cUvYqrWHApDtUcVFYy
      a+nD2UsR0MYxCmvPFVGyxxSRWCZWTrDSpUz1oXIPX2ah0cM/MQapfL2sSamMmeYj
      HazKR4ucDVk0BfEMSfJBb/dd3ArQrN7jke7kBxjRV2szLts0BzVCRI/Ru6WD9KyD
      WdvrRoSfc3BoHwczrr4lLL0yOp5ygm43WzgE8WilvxhbrVnHMs9t3S5hA81akvvY
      GZDHKsJGDPNGYOdCebtGrrmY3p+AmymU6vDBld9pVEp8RkVpY5A1OKEhgNcdG+C7
      LRjSHMWS8CsFQxASOUXpkEjbLo9EgBiD8E454jEOncJqSThvZO9D1HiQU78IZj/x
      sU+aVuwAfQLkzt8kvKOVw/7B1ywy72TKKWBXMRg3+qk5qb1MRKz0HMCBRzxCnW2s
      2poWbpOoK+IL5x50h72zW9mNq2Unz0/tl105nbPVc/RtMSuDF2Yw3zfKIX+1+izh
      0UYHNckeg749vbVwMBYcxl+O0iMoZMKQKxrx8HqLyJ/rai57ch4X5v3jUnkrmCOQ
      mp/YhOREjYynhAhk6m3xnCCMwcapzQyd2Rb0vsr9qErxm4MNa91OGgR8oS9xK3Ok
      3jefCkzqgiEjxUcqaD/0UZ9umMj7jhrCPXSumfqgbGhixTxNuKkyAOIXPVUnLu3S
      YwFnrIIVC1UOPwaIRv+h4btDc6oeQ184kPgd7O+b7Ff9fQhCOYmw3yr/en/Leqe+
      Uq1gkhj1XIIXZrmd8t268doili1hsgxFp02O+EQEPjgZuaNuOAql7z00JR9GzVe0
      tWmE7A==
      =rJ03
      -----END PGP MESSAGE-----
  zone: |
      -----BEGIN PGP MESSAGE-----

      hQIMA7+DShJS+9zMAQ/+Jlde/KVqMvTMPPwNi6piKT1zdRcLoLbh+kKJ8GOyLRoz
      lqdFe8aFRGNihhlgllZinyKcthzK12g/W1oCmqQDNVJIRjdNa4H7BizvgGzRrxHP
      e17W0juI7O34DWAYKN/NnlbjSSLtMMkGbp+0OjV3P07HwfuMQP5d7K0VihtLVwJk
      KI8NqixbqFjDKwtDXL0woFlAtKCayBSA6wNl4CRKejMf6WqFUmwDtbctPC2BkeUo
      +Dzk04+3k550xUTtRlobmRa0WtDwMXhPGcjjPkDM9XDM+eUr/aU4RvKt0j1jdRww
      Js8o+w+pafRCypeUk0bGVy00f0krUov6uHZmcgt5FRXCrSdlbdcAXP8CDKTq2Q9p
      qGhqvyM0y/CaC3OtLpKdbtwHEJEeiIgZ40uxS7U6azKwjo+VxCrYYitsH1VncVHF
      HDKplYME5x8CGm6jz78UgwGFDJBZetFoB6PV56NWMaarTF+acI3a4+GSGfhCnb1Z
      7LKpK/uk3k/hDzlCK22JfsxlnlNNJu5EExOTPpV+G8qRxkxgBl2K7ZMPoQfCEX6U
      f4ZvIlK6Sv94C0iiprr4zOZWG6z+OlRmjWg3ELGYDVfMU4JGGno7zybcFuUZF+Ox
      rfBBwxOXfa4adXRnGqhJDV4Rdx6iZmDd9ewVqj2nwEdmIW8+50w+qjxJuPOMNpDS
      WwHS31xdU0P2/hB7MTvbnzxp7vA1oNv4DMe8spc60IGVCz8C8bNX7JIYLDY9lgkL
      UPAsBY221D3OtqsmLj03FShf/WK+5S+s+qiQbWcZ1TYn8p8YF20iPfle8ZE=
      =aZ/l
      -----END PGP MESSAGE-----
{% endif %}
