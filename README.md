# directslave
DirectSlave docker based on alpine
### Check it out on [directslave.com](https://directslave.com/)

[![GitHub Source](https://img.shields.io/badge/github-source-ffb64c?style=flat-square&logo=github&logoColor=white&labelColor=757575)](https://github.com/scraane/directslave)
[![GitHub issues](https://img.shields.io/github/issues/scraane/directslave?style=flat-square)](https://github.com/scraane/directslave/issues)
[![GitHub license](https://img.shields.io/github/license/scraane/directslave?style=flat-square)](https://github.com/scraane/directslave/blob/main/LICENSE)
[![Docker Pulls](https://img.shields.io/docker/pulls/nutjob/directslave?style=flat-square)](https://hub.docker.com/r/nutjob/directslave)


## About (from directslave.com)
This software (DirectSlave) is designed for fast & easy slave DNS management, interacting with DirectAdmin powered servers using DirectAdmin multiserver API. Configuration of master DirectAdmin server is not necessary, software provides DirectAdmin multiserver API emulation via HTTP protocol. You only need to enable Multi Server feature on master DirectAdmin server and set it up to work with DirectSlave. Basic understanding of DNS basics also might be helpful.

## Directslave version
### Using 3.4.2

## Usage
Here are some example snippets to help you get started creating a container.

### docker-compose (recommended)
```
---
version: "2.1"
services:
  heimdall:
    image: nutjob/directslave
    container_name: directslave
    environment:
      - SSL=on
      - EMAIL=your@email.com
      - DOMAIN=ns02.yourdomain.com
    volumes:
      - directslave:/app
    ports:
      - 80:80
      - 2224:2224
    restart: unless-stopped
```

### docker cli
```
docker run -d \
  --name=directslave \
  -e SSL=on \
  -e EMAIL=your@email.com \
  -e DOMAIN=ns02.yourdomain.com \
  -p 80:80 \
  -p 2224:2224 \
  -v directslave:/config \
  --restart unless-stopped \
  nutjob/directslave
```

## Setup
### SSL is optional, but recommended!

Port 80 and 2224 will need to be mapped for SSL. Otherwise only port 2222 is needed.

### When starting for the first time check the log files for the admin password!
### I recommend you go to manage users, create a new one and delete the admin account!

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate <external>:<internal> respectively. For example, -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080 outside the container.
  
|Parameter|Function|
|---------|--------|
|-p 80|port needed for letsencypt|
|-p 2222|non ssl port directslave|
|-p 2224|ssl port directslave|
|-e SSL=on|enable ssl encryption using letsencrypt|
|-e EMAIL=your@email.com|email address needed for letsencrypt|
|-e DOMAIN=ns02.yourdomain.com|domain to register the ssl cert|
  
## Updating Info

Below are the instructions for updating containers:

### Via Docker Compose
* Update all images: docker-compose pull
  * or update a single image: docker-compose pull heimdall
* Let compose update all containers as necessary: docker-compose up -d
  * or update a single container: docker-compose up -d heimdall
* You can also remove the old dangling images: docker image prune

### Via Docker Run
* Update the image: docker pull nutjob/directslave
* Stop the running container: docker stop heimdall
* Delete the container: docker rm heimdall
* Recreate a new container with the same docker run parameters as instructed above (if mapped correctly to a host folder, your /config folder and settings will be preserved)
* You can also remove the old dangling images: docker image prune
