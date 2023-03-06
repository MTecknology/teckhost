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
        =Gy8B
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
