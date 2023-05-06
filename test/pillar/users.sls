#!yaml|gpg

# This!5@TestPassword
root_pass: |
    -----BEGIN PGP MESSAGE-----

    hQIMA6i5MAntRwqiAQ//V1+wv1tarUSOo8ZH9n5KVcbRtZjGaeHAKNMpUeGn++AM
    yWQEcpkDMSuFfeueoiOyR7Z2jjxEjSuaDZlgBuizWm5YhB5u0HuhkT/Z5jwvc6yq
    4ZQE2ll+a+NzRnxoHK8MebTPFANgTQdjI4gzTeIVCjIoxto1d0pBAkzB9MvxbU4L
    YCbabNT0+RRpXlCqHKxzS3EoIGOo4fljJ7ibGcjh+l0JUPH0w4UtgzkWEvT2Qlaz
    8Orxj8Lro6x72BFhN9NGa01WRzH12q9nxbFpRfA0TrC1Iu7cL8RuAGXUKC0B5Vf6
    QcEfoxUeaN956C4ZY7duMstZL9viChXDZSRJcp1Vm2ecn58MFJ0Y/npNzmzTleVn
    Qy1Iodsx005XVCHGW/EYhLhN0ej0/zFGUghGKosWJ5POgQ+MhVbeOKaneQ+pI/8W
    M+Gnea9juGO5q6G+Njv+YZcASqenxQDuha8wQt4sEEf8tjAfu+Db8inNv9VRRVN+
    StfBejHgVCLrgT42IsVc1GQQV8eeMhBd6RVGnqll4cDiP5l0GpE1pgNEtZmKF0Ut
    YLEoD6ZETVfW9Xr49KvavRzttOsPAx4onYSm7hUckQonLXWjxbTiOnq3VJwE1BWY
    YKBJNypBwvSVdkqn+V1Cm//sMMg2AzN06c6/LwVFyUM18NsMw5dqTXgXQD/sCQ3S
    hAGfIPA5uTgm+Kfv/Myp2+07NoDULpLV3p67NgYsiDosYPD84XeQVEDzdYsaK2cv
    Z/e1Wxo/5kc91BZOYgL1GZkmGCzRahdKhzZEX3fkr+7RKHmCgtog1RiRUPriz6Rf
    Eqvdt4A7+q4NSJzZRh/dUeCudVlEXrE+IzvLYvllYK7yCPdW4w==
    =S+As
    -----END PGP MESSAGE-----

device_users:
  # All devices using test/pillar data will use these users
  - testuser
  - testadmin

users:

  testuser:
    ugid: 4242
    groups:
      - ssh-user
    # SuperInsecurePassword4Testing
    pwd: |
        -----BEGIN PGP MESSAGE-----

        hQIMA6i5MAntRwqiAQ/+PIiUpASO7f70Y5Hf3Y8CBBIXMR2J8s7/FGwaHENnv0Di
        hTBHJb0wQ68UhxD4VMA0A0Zbx4+c9IEOTz8wcqfLV+Gc4GnYxOhN3F3DXipdHnrk
        gHdi2lQ+JrBji4rRMDVWAvtaoWb6C5FSIDaU395uE0ku0yeFC5ETGfRjiFVfKcgZ
        sLE1cje7WFsoAZKTb9HcKg/wBdw7jw2rX1Rjom6Xjil313eIMvRI0Fu/XwfwJqPh
        upRGb/+KCn2zLQv0hgckbvlkKNq33t7jNOjK46IglRJTR3hd8Ee9z4O2DppsD2tQ
        eA2kY0x6OzfsCH3dQJlX5ya/Z1KHL0YH6HSOvdq806UUtAdZzhb9Glyg/bY1YtQI
        qg4avLJ3942LAuHxAd1XycGy72ttpn6T+DOtPOK+5XUUJQj1Vjm6EG4qujxTl5pY
        67rVvW+BGJ9ur1I6//2oFudWdfu5oezqyllsDe8Jj6h3JPFX/wp8qUysUcoxSVV4
        UyZqpla1uPp8UKmuocbe17T3UeKwiQffRyGKDqhIJ6cg+oh5bgQ9136VZsOVIx79
        zHoiM4dsuy/CZXr7hzVHcIBOtkSVE2yQpysLdSnKHtEyh/oQpy7YNJFkJlZe8Or1
        dStr2I9ysP81M3ZO6jgoZcDC0v5wLVGYggWjsM7Pc8cHh3dx3wSoWhYaO4hgchfS
        hAGMmJ4v5fqPzxdeo7wCbC6oKQCR7/EvWndSdU5U86EwAxBKllAdYpIK4BSMjZvZ
        X+bpwdBcO0hBTS8cse/ShXeU7H29kMD0CjLOxcq5fQvtMUvwyO/PGXL/CKGTli+O
        CY0XOq5SsiM4q9VD/Obtrc7Yzapg83/YpU694kV+1bBmBYWrFQ==
        =ruPa
        -----END PGP MESSAGE-----
    keys:
      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDe0u5JOMP2RO8H/gUAizLoPWvRsgZXYXicjapOd8nlb tester@testpc1

  # NOTE: This user is a clone of 'testuser' with added groups
  testadmin:
    ugid: 4243
    groups:
      - ssh-user
      - sudo
    # SuperInsecurePassword4Testing
    pwd: |
        -----BEGIN PGP MESSAGE-----

        hQIMA6i5MAntRwqiAQ/+PIiUpASO7f70Y5Hf3Y8CBBIXMR2J8s7/FGwaHENnv0Di
        hTBHJb0wQ68UhxD4VMA0A0Zbx4+c9IEOTz8wcqfLV+Gc4GnYxOhN3F3DXipdHnrk
        gHdi2lQ+JrBji4rRMDVWAvtaoWb6C5FSIDaU395uE0ku0yeFC5ETGfRjiFVfKcgZ
        sLE1cje7WFsoAZKTb9HcKg/wBdw7jw2rX1Rjom6Xjil313eIMvRI0Fu/XwfwJqPh
        upRGb/+KCn2zLQv0hgckbvlkKNq33t7jNOjK46IglRJTR3hd8Ee9z4O2DppsD2tQ
        eA2kY0x6OzfsCH3dQJlX5ya/Z1KHL0YH6HSOvdq806UUtAdZzhb9Glyg/bY1YtQI
        qg4avLJ3942LAuHxAd1XycGy72ttpn6T+DOtPOK+5XUUJQj1Vjm6EG4qujxTl5pY
        67rVvW+BGJ9ur1I6//2oFudWdfu5oezqyllsDe8Jj6h3JPFX/wp8qUysUcoxSVV4
        UyZqpla1uPp8UKmuocbe17T3UeKwiQffRyGKDqhIJ6cg+oh5bgQ9136VZsOVIx79
        zHoiM4dsuy/CZXr7hzVHcIBOtkSVE2yQpysLdSnKHtEyh/oQpy7YNJFkJlZe8Or1
        dStr2I9ysP81M3ZO6jgoZcDC0v5wLVGYggWjsM7Pc8cHh3dx3wSoWhYaO4hgchfS
        hAGMmJ4v5fqPzxdeo7wCbC6oKQCR7/EvWndSdU5U86EwAxBKllAdYpIK4BSMjZvZ
        X+bpwdBcO0hBTS8cse/ShXeU7H29kMD0CjLOxcq5fQvtMUvwyO/PGXL/CKGTli+O
        CY0XOq5SsiM4q9VD/Obtrc7Yzapg83/YpU694kV+1bBmBYWrFQ==
        =ruPa
        -----END PGP MESSAGE-----
    keys:
      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDe0u5JOMP2RO8H/gUAizLoPWvRsgZXYXicjapOd8nlb tester@testpc1

  # NOTE: This user is defined but should not be used
  testgone:
    ugid: 4244
    groups:
      - ssh-user
      - sudo
    # SuperInsecurePassword4Testing
    pwd: |
        -----BEGIN PGP MESSAGE-----

        hQIMA6i5MAntRwqiAQ/+PIiUpASO7f70Y5Hf3Y8CBBIXMR2J8s7/FGwaHENnv0Di
        hTBHJb0wQ68UhxD4VMA0A0Zbx4+c9IEOTz8wcqfLV+Gc4GnYxOhN3F3DXipdHnrk
        gHdi2lQ+JrBji4rRMDVWAvtaoWb6C5FSIDaU395uE0ku0yeFC5ETGfRjiFVfKcgZ
        sLE1cje7WFsoAZKTb9HcKg/wBdw7jw2rX1Rjom6Xjil313eIMvRI0Fu/XwfwJqPh
        upRGb/+KCn2zLQv0hgckbvlkKNq33t7jNOjK46IglRJTR3hd8Ee9z4O2DppsD2tQ
        eA2kY0x6OzfsCH3dQJlX5ya/Z1KHL0YH6HSOvdq806UUtAdZzhb9Glyg/bY1YtQI
        qg4avLJ3942LAuHxAd1XycGy72ttpn6T+DOtPOK+5XUUJQj1Vjm6EG4qujxTl5pY
        67rVvW+BGJ9ur1I6//2oFudWdfu5oezqyllsDe8Jj6h3JPFX/wp8qUysUcoxSVV4
        UyZqpla1uPp8UKmuocbe17T3UeKwiQffRyGKDqhIJ6cg+oh5bgQ9136VZsOVIx79
        zHoiM4dsuy/CZXr7hzVHcIBOtkSVE2yQpysLdSnKHtEyh/oQpy7YNJFkJlZe8Or1
        dStr2I9ysP81M3ZO6jgoZcDC0v5wLVGYggWjsM7Pc8cHh3dx3wSoWhYaO4hgchfS
        hAGMmJ4v5fqPzxdeo7wCbC6oKQCR7/EvWndSdU5U86EwAxBKllAdYpIK4BSMjZvZ
        X+bpwdBcO0hBTS8cse/ShXeU7H29kMD0CjLOxcq5fQvtMUvwyO/PGXL/CKGTli+O
        CY0XOq5SsiM4q9VD/Obtrc7Yzapg83/YpU694kV+1bBmBYWrFQ==
        =ruPa
        -----END PGP MESSAGE-----
    keys:
      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDe0u5JOMP2RO8H/gUAizLoPWvRsgZXYXicjapOd8nlb tester@testpc1
