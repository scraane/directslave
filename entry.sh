#!/usr/bin/env bash

# if the security key is not set yet (first time run) we set it
echo Changing security key if needed
sed -i 's#Change_this_line_to_something_long_&_secure#'"$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)"'#g' /usr/local/directslave/etc/directslave.conf

# checking if directslave.inc exists. If not we create an empty one, otherwise we skip
if [ -f "/app/directslave.inc" ]; then
    echo "/app/directslave.inc exists. Skipping"
else 
    echo "/app/directslave.inc does not exist. Creating"
    touch /app/directslave.inc
fi

# checking if passwd exists. If not we create an empty one, otherwise we skip
if [ -f "/app/passwd" ]; then
    echo "/app/passwd exists. Skipping"
else 
    echo "/app/passwd does not exist. Creating"
    touch /app/passwd
    chown -R named:named /app
    PASSWD=$(openssl rand -base64 12)
    # here we add the default user admin with very secure password password
    /usr/local/directslave/bin/directslave-linux-amd64 --password admin:$PASSWD
    printf "\r\n\r\n*****************************************************************************************\r\n**\r\n"
    printf "**  We are probably starting for the first time with no username and password. Creating now\r\n"
    printf "**  >--> default: admin / %s " "$PASSWD"
    printf "\r\n**\r\n*****************************************************************************************\r\n\r\n"
fi

# make sure bind is owner of the /app folder
chown -R named:named /app
chmod -R 777 /app
chown named:named /etc/bind/named.conf

# check our config
/usr/local/directslave/bin/directslave-linux-amd64 --check

# run supervisord
/usr/bin/supervisord -n -c /etc/supervisord.conf
