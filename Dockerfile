FROM alpine:latest
RUN apk --no-cache update
RUN apk --no-cache add bash bind supervisor logrotate
RUN rm -rf /tmp/* /var/tmp/*
COPY ./directslave.logrotate /etc/logrotate.d/directslave
COPY ./named.conf /etc/bind/named.conf
RUN mkdir /var/cache/bind
RUN chown -R named:named /var/bind /etc/bind /var/run/named /var/cache/bind
RUN chmod -R o-rwx /var/bind /etc/bind /var/run/named /var/cache/bind
RUN mkdir /etc/supervisor.d
ADD directslave-3.4.1-advanced-all.tar.gz /usr/local/
COPY ./directslave.conf /usr/local/directslave/etc/directslave.conf
RUN cat /usr/local/directslave/etc/directslave.conf
RUN rm /usr/local/directslave/bin/directslave-freebsd-amd64 /usr/local/directslave/bin/directslave-freebsd-i386 \
    /usr/local/directslave/bin/directslave-linux-arm /usr/local/directslave/bin/directslave-linux-i386 \
    /usr/local/directslave/bin/directslave-macos-amd64
RUN mkdir /app /app/slave /app/logs
RUN chown -R named:named /app
RUN chmod -R 777 /app
RUN chmod +x /usr/local/directslave/bin/* && chown -R named:named /usr/local/directslave
COPY ./supervisord.conf /etc/supervisor.d/supervisord.ini
COPY entry.sh /entry.sh
RUN dos2unix /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]
EXPOSE 53/udp 53/tcp 2222/tcp