#!/bin/sh
/lib/modules/"$1"/build/scripts/sign-file sha512 /root/.mok/mok.priv /root/.mok/mok.der "$2"
