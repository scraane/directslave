FROM alpine:latest
RUN apk update
RUN apk add bash bind supervisor
RUN rm -rf /tmp/* /var/tmp/*
#RUN cp /etc/bind/named.conf.authoritive /etc/bind/named.conf
COPY ./named.conf /etc/bind/named.conf
RUN mkdir /var/cache/bind
RUN mkdir /etc/supervisor.d
ADD directslave-3.4.1-advanced-all.tar.gz /usr/local/
COPY ./directslave.conf /usr/local/directslave/etc/directslave.conf
RUN cat /usr/local/directslave/etc/directslave.conf
RUN mkdir /app /app/slave /app/logs
RUN chown -R named:named /app
RUN chmod -R 777 /app
RUN chmod +x /usr/local/directslave/bin/*
RUN chown -R named:named /usr/local/directslave
RUN /usr/sbin/named-checkconf /etc/bind/named.conf
#RUN echo 'include "/app/directslave.inc";' >> /etc/bind/named.conf
COPY ./supervisord.conf /etc/supervisor.d/supervisord.ini
COPY entry.sh /entry.sh
RUN dos2unix /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]
EXPOSE 53/udp 53/tcp 2222/tcp