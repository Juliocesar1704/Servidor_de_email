FROM ubuntu:latest

RUN apt update -y && \
    apt install bind9 dnsutils -y

COPY named.conf.local /etc/bind/named.conf.local

COPY nexustech.com.br /etc/bind/nexustech.com.br

RUN mkdir -p /run/named /var/cache/bind /var/lib/bind && \
    chown -R bind:bind /run/named /var/cache/bind /var/lib/bind /etc/bind

EXPOSE 53/tcp
EXPOSE 53/udp

CMD ["/usr/sbin/named", "-g", "-c", "/etc/bind/named.conf.local", "-u", "bind"]