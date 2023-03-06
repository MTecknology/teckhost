#!jinja|yaml|gpg

users:
  michael:
    ugid: 1000
    teckuser: True
    groups:
      - ssh-user
      - sudo
    {% if (salt.match.glob('*pc*') and not salt.match.glob('mikepc*')) %}
    pwd: |
        -----BEGIN PGP MESSAGE-----

        hQIMA7+DShJS+9zMARAAsDEv00ExBFMD7kiMyor6RSRggYT22HtFiNJf4dfIukMF
        kg0vtTdEslRng6L8nBoQA08+K+1IetEJw8WZ1gZSVHE3o5Ot2wWoTwc5jT4tH2lN
        NoFIQvZ/1gPBO2+qxcoPUPt6t013/KhZOS5U+UYBL/beNS4iyD/VULC4kfPNqway
        X/KfyYgilC+8/8MAqmFJZyASEMP9twJ8az8UIfoKLVO4zWG1V5491WACdtepRJ0J
        tOktuBBiAh/hgLmGu6Zxqo1I9rutoiBX2r9B5BQ9aKNVaI+sO2wCAALSpCD5BXb8
        6axwr5bkKH1RPfCi3yKhn63Q3s6zrUhhazGP92KS+AuCaoRl7gRf92WFikuISZeT
        khbchpKpAsMewJQTrjBPLORsz0VstZ9awYglGLYaLpDEvNyPvfHmZrRiPuVD4fzK
        3fO7nwdG420PvuQgVspV2Ag0Ifa4fFgxE7yejvvcP2bUOgABDv89eDEuHl8OVimi
        jYlFyfwJKDA6+ZezDPxu/WrQ5zcYAPvu3kBO3j64ri89eilh2tyyIUNDTrFUVESE
        xspRSdvTLJfytkTCAYTrIP/g+3NV/+myLi72mEdvvS+gVRgoAy1ZBXTzLVn4PeIb
        Woz7Iuri0moPPlT8pLVwpQSkKn2wg+aWyLe4Z/i82ZhxEQJPMsgfr7Npvoh5elTS
        hAH1a1Pd4FhttrFQ1X5WE61hp22IIoPMrUbWQTjTtoEQZc3lgoljZRXiEX6RbaYb
        /iF1T+rqK6DNjDZ7zhc6HvOyXXkewhFMOQR84rIt2Y4pIqPlLcoH5YrJq6wYcThZ
        sD8pLgq3sdvawWPdlRlpwJKSb50V3sqzeOCgMl/DpduU6tww4g==
        =jk+2
        -----END PGP MESSAGE-----
    {% else %}
    pwd: |
        -----BEGIN PGP MESSAGE-----

        hQIMA7+DShJS+9zMARAAnODyFhB8OpnTVDdIDNLDhrcZwAF13+o9m8LTZZ14xAkd
        nMp4pBgqCzg06U/52B4ymRFMH3gIypPbaRIsbrsnKa/sQ2RpUzpEDd5pV5A0fi5/
        dYP4TDe0YDDgyB44J+cwXOuPAx5oglZRz++zu+Yta6vKrTHI4vup+NkZgbCpYpEA
        IN5ldslz+dOiUPPa4mx4sctUJYs0JMt5vAZyZNwKDOZnU9PCwLQnn1bWgYNmAWSL
        qIHmgDTHdEpopbtH1eviU9S2bcB74mEg87SfnwiTjaljDlGcjZSZGuXV6DCkSIPl
        fQ6OZ9/S6JjUVUHJPHcICaZvxSjV0QUDK1lOD6Ui8jIgUf9AcWsCuzZyQzX6e86J
        mF0ZAn/rvoI8in+XXujJx25wc47O1W+AE6L8ELhK1O3OlfnvbWxzjJtIXULxmgEo
        CCKYGihpLtb3YwhkHoDIEmh3aLqSgLtiEQvupiZs06NBZvQR6usuWL9ucmGEG6jn
        QhwaYT3orTjN1Z1X5Tu3kFcAdtspHjmZZQCA4sT89qmX9zUaQVDyER7HsSbXVI5S
        fOi8RnLzFAPdwT5Dwk8VrRP8hfrx0NNm1TG57aW+/PaJaGBY/lOxatd2OmpKFbE1
        yKHxsl8PTTqlZcUiBcEMJjF91VCaTJDNUtSADblhCoRKGThTNoFZTCGl8et10IPS
        hAEerleooNcrE7yU9wQ8V/bdwYYX4AiV5KPmjm6ZlF8u3Xwgpy5+peIsJ/f5drwR
        30QqOZXQHYgCd557Rx2Hs4u6YRrncVVs1MEoY4U51oU5Vxd/NXKWCHZxkul+615b
        liWgWAaUjUlpLBqNKh2yYsvmFvI70W7WTzweSUgo8eYFK3U0rA==
        =ECwb
        -----END PGP MESSAGE-----
    {% endif %}
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

# Extra stuff for my laptops
teckhost_extra:
  printers_config: |
      -----BEGIN PGP MESSAGE-----

      hQIMA7+DShJS+9zMAQ/8Cg+/+Vg7OaTvfM+QX0DcKMc8bLaqktJ0Tr+v41UAYOA4
      9iq8kC8vhAxvXPIoivWliSLY/+wJmVw8NPvQ9UCge21g7h2PhQz6nNOgnMG6N6Wf
      AC5JXLM1uzhXVunDfcQLb3GHM3x2WGFRTYq2IQqm1Y8ZIAhoWLKoeHOLjJafSrJy
      pnWQ9v73Naqkh3uXC87oajnMzuH+k9xSbmJ9ZBS2pCzvgZGmeIFEqUY63UbX1jTK
      GuBrpqTngvqG8sY3K65cm5mlWw5YfZGdD11zTy5mmJFWu084gbULIGT4238GeqgZ
      gn/msChUxDs9EVc6g63TkOAfIeqRzAw7zNWZqus/ecK1fcf+1IVjrlSl9kUcKDVr
      RO1Jv3vsHvX1DmYEipbzj6SriZexK41OFY49nBm2pTrBikmcjzBa+OF7uttE9by+
      7t1CctZnBs/D1tf+ea6dAPqbyvVqXpImEQpDdLB7CWcDd+R0WQS/A1iETSZi2eAz
      AxQHFWLhoIC5Oi54evxo608J9HVyF9fu+/mciP6rptyfUSpv9mEj/jthwSUz14f0
      RxTE7v9M81S+8eTyJTDJE+AQXMbwC1hfZEjQb7D0NstN4bCM34rx/NvPlfiU8AvW
      jCG9OSFTr3KYu9cpGt+9cTovmQtYByaZKzFzh0TxlRhgGS6hrmyLXywnsP0YGPTS
      wR0Bfc47BoY1pWy/TMJBBmbMZJpbU0dJNp6+jvt6jqmfPCoDvYSzK9S4ASwYaiAd
      iUM8LHRiP0rCPK+JzgyfRZp/lUvFiSG2mNX5aqcA/RY04Tg1YjMuXqOZYN0nDun5
      b9ObrZi59dI5aCwYp0Im2wBdz3zhaUpngO3kpUJYSFaaY1DeCpRHqccpqJGUAUJu
      LkG9lQ2LioKQkI0PO9GvgK9bkoUNpoWtjdSxTLayCTGFbhtkAdrA0G2uGnJYMtvh
      A+ikuYok0MNDDFPTENF894hFSGahvY65vcPj0I6psPMVfgcomG/4FWJyPW+j2WqJ
      A1hknpyFgHVO6tE4FltJJGsbwd+30NUOB6kl6/QTF/q/vU8cXuPUFD0nmPTXFxbF
      zWEL+6eqlH6gp+T+rWienPqoxh81Ejj5NaKZYusinEeEZCEvFG/cY2/r8rMxjxse
      A+R34pZ8yEzfrJ2FZKO6MS871+FiWyMfNgyxBsy47LGSchNvSchjtR5+PenQOMda
      LGw9vmoPkfzW1nSWHS4u9Q0tTgfQzyXYmyW/woQdxYlGJzqjtHfm7n2+R9ANhDCx
      yRm6CrHdk7wvSBAztJgpoE73x+Fh8NBIEj6mH5VhLMvkNxjkvRReyX1UKyX3rDY=
      =D4np
      -----END PGP MESSAGE-----
