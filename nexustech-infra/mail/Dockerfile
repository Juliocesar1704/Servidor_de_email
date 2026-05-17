FROM debian:latest

RUN apt update -y
RUN apt upgrade -y

RUN apt install postfix dovecot-imapd dovecot-pop3d dovecot-lmtpd telnet nano syslog-ng procps net-tools -y

COPY ./postfix/* /etc/postfix
COPY ./dovecot/* /etc/dovecot/conf.d
COPY mailname /etc/mailname
COPY mail.sh /etc/init.d

RUN chmod 755 /etc/init.d/mail.sh

RUN mkdir -p /etc/skel/Maildir/{cur,new,tmp}

EXPOSE 25/tcp
EXPOSE 587/tcp
EXPOSE 110/tcp
EXPOSE 143/tcp
EXPOSE 993/tcp
EXPOSE 995/tcp

VOLUME ["/var/mail"]

CMD ["sh", "-c", "service syslog-ng start ; service postfix start ; service dovecot start; tail -F /var/log/mail.log"]