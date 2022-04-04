FROM alpine:latest
VOLUME /app
RUN apk --no-cache update && \
    apk --no-cache add bash bind supervisor certbot openssl && \
    rm -rf /tmp/* /var/tmp/* && \
    mkdir /var/cache/bind && \
    chown -R named:named /var/bind /etc/bind /var/run/named /var/cache/bind && \
    chmod -R o-rwx /var/bind /etc/bind /var/run/named /var/cache/bind && \
    mkdir /etc/supervisor.d && \
    curl -O https://directslave.com/download/directslave-3.4.2-advanced-all.tar.gz && \
    tar -xf directslave-3.4.2-advanced-all.tar.gz --directory /usr/local && \
    rm directslave-3.4.2-advanced-all.tar.gz && \
    rm /usr/local/directslave/bin/directslave-freebsd-amd64 \
    /usr/local/directslave/bin/directslave-freebsd-i386 \
    /usr/local/directslave/bin/directslave-linux-arm \
    /usr/local/directslave/bin/directslave-linux-i386 \
    /usr/local/directslave/bin/directslave-macos-amd64 && \
    chmod +x /usr/local/directslave/bin/* && \
    chown -R named:named /usr/local/directslave
RUN    curl https://raw.githubusercontent.com/scraane/directslave/main/named.conf && \
    curl https://raw.githubusercontent.com/scraane/directslave/main/directslave.conf && \
    curl https://raw.githubusercontent.com/scraane/directslave/main/supervisord.ini && \
    curl https://raw.githubusercontent.com/scraane/directslave/main/entry.sh && \
    mv named.conf /etc/bind/ && \
    mv ./directslave.conf /usr/local/directslave/etc/ && \
    mv ./supervisord.conf /etc/supervisor.d/ && \
    mv ./entry.sh /
#COPY ./named.conf /etc/bind/named.conf
#COPY ./directslave.conf /usr/local/directslave/etc/directslave.conf
#COPY ./supervisord.conf /etc/supervisor.d/supervisord.ini
#COPY entry.sh /entry.sh
RUN dos2unix /entry.sh && chmod +x /entry.sh
HEALTHCHECK CMD curl --fail http://localhost:2222/ || exit 1
ENTRYPOINT ["/entry.sh"]
EXPOSE 80/tcp 53/udp 53/tcp 2222/tcp 2224/tcp
