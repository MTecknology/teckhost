#!jinja|yaml|gpg

webapps:
  {% if salt.match.glob('irc.lustfield.net') %}
  mtpaste: paste.lustfield.net
  ipecho: ip.lustfield.net
  {% elif salt.match.glob('*.sober.page') %}
  soberpage: None  # monolithic
  {% endif %}

##
# App Tokens
##

{% if salt.match.glob('*.sober.page') %}
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

      hQIMA7+DShJS+9zMAQ//eDtu7AZ3fStVdu2jvYdMmgSpIqXOdtvfbDvk525WiQDC
      HXqOHeTiyc5jFtvEHrJj1iswldk4XRPHhVyPL9icsNQpoSFPh2bf3xSIHLpzoeP8
      PQr8yQww4M9ZFabBwVijI2nHUm+XUCj0T6kQxWiCe7RPe+hpkmZ+tHJQLx5mURsi
      CKDHegMKMoISU53htNee511sX0VTUX+JnYrN91rgEbLfHZwrBN/iwsO42HgcrGIr
      antdPUPs0V7EgPB0eN62kPXrb/0wK2z4y0Bq65ZqIPvM4+x8DJfM3b4AUzq+4qYI
      7xlde7vsr2vXSoEpieF+7Na4KZcBR4CMLmDqXJwPltaqmeyEYFn+OMc5uK4NaiMq
      u8UX2xCk+R5xZBoHBDhqejl+qwmZzaXiqCbCpMRpGcv1lmO9um30ItxSsV6rZnDr
      +UMOqhf18XsheToMa9fCqAoYMXQO9U9pSzS+klToe+eeoSuFI+m34mQXwJ702IJG
      E19+LNB67bVpgOWusoF/w2HgZ73qKguW9yvZRdsLoT6ZZXSk2wtrrKFHfRdRRB2h
      Lvh9Q13S7BXJM7zQ+8MJdrKq+DIxyCZoW3425XvPWmnsTqCIf5JHXUGrQw8zRDBg
      JeNCQBmlTU4Mk+wtk6HSjPitUv5OcO38LrChPDsD1pg3+lUArYxsbaU62QfYgPfS
      WwFM5I2vBEQuJugnNJlwg/MCirns1HCpGykNfBdgrDF7bA7MH0a9Ce8Gv1gQKoJc
      dmjaNa+bthUdCKwZ8Hj4JswQ1ZLCSE1K3LMMH5UE20bM3ctyXr3qufGsZwo=
      =mLa6
      -----END PGP MESSAGE-----
{% endif %}
