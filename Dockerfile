FROM alpine:latest
RUN apk update
RUN apk install bind9 nano supervisor -y --no-install-recommends
RUN apk clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY ./named.conf.options /etc/bind
ADD directslave-3.4.1-advanced-all.tar.gz /usr/local/
COPY ./directslave.conf /usr/local/directslave/etc/directslave.conf
RUN cat /usr/local/directslave/etc/directslave.conf
RUN mkdir /app /app/slave /app/logs
RUN chown -R bind:bind /app
RUN chmod -R 777 /app
RUN chmod +x /usr/local/directslave/bin/*
RUN chown -R bind:bind /usr/local/directslave
RUN /usr/sbin/named-checkconf /etc/bind/named.conf
RUN echo 'include "/app/directslave.inc";' >> /etc/bind/named.conf
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY entry.sh /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]
EXPOSE 53/udp 53/tcp 2222/tcp