FROM alpine:latest
RUN apk --no-cache update && \
    apk --no-cache add bash bind supervisor certbot openssl && \
    rm -rf /tmp/* /var/tmp/*
COPY ./named.conf /etc/bind/named.conf
RUN mkdir /var/cache/bind && \
    chown -R named:named /var/bind /etc/bind /var/run/named /var/cache/bind && \
    chmod -R o-rwx /var/bind /etc/bind /var/run/named /var/cache/bind &&
    mkdir /etc/supervisor.d
ADD directslave-3.4.2-advanced-all.tar.gz /usr/local/
COPY ./directslave.conf /usr/local/directslave/etc/directslave.conf
RUN cat /usr/local/directslave/etc/directslave.conf
RUN rm /usr/local/directslave/bin/directslave-freebsd-amd64 /usr/local/directslave/bin/directslave-freebsd-i386 \
    /usr/local/directslave/bin/directslave-linux-arm /usr/local/directslave/bin/directslave-linux-i386 \
    /usr/local/directslave/bin/directslave-macos-amd64
RUN mkdir /app /app/slave /app/logs && \
    chown -R named:named /app && \
    chmod -R 777 /app && \
    chmod +x /usr/local/directslave/bin/* && \
    chown -R named:named /usr/local/directslave
COPY ./supervisord.conf /etc/supervisor.d/supervisord.ini
COPY entry.sh /entry.sh
RUN dos2unix /entry.sh && chmod +x /entry.sh
HEALTHCHECK CMD curl --fail http://localhost:2222/ || exit 1
ENTRYPOINT ["/entry.sh"]
EXPOSE 80/tcp 53/udp 53/tcp 2222/tcp 2224/tcp
