# directslave
DirectSlave docker based on alpine

[![License]https://img.shields.io/github/license/scraane/directslave?style=flat-square]

When using the docker-compose file it will all be setup for you.
A volume will be created and mapped to /app in the docker.
If you dont use the docker compose you will have to mount /app to
a volume or path yourself.

After starting open webui on port 2222 and login with admin/password.
Go to manage users, create a new one and delete the admin account!