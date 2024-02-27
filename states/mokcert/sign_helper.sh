#!/bin/sh
/lib/modules/"$1"/build/scripts/sign-file sha512 /root/.mok/client.key /root/.mok/client.der "$2"
