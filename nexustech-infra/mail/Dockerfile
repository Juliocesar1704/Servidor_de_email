FROM ubuntu:22.04

# Evita que o instalador do Ubuntu fique travado fazendo perguntas na tela
ENV DEBIAN_FRONTEND=noninteractive

# Atualização do sistema e instalação dos serviços essenciais
RUN apt update -y && apt upgrade -y && \
    apt install -y postfix dovecot-imapd dovecot-pop3d dovecot-lmtpd \
    telnet nano syslog-ng procps net-tools && \
    apt clean

# Copiando as configurações do Postfix e o Mailname
COPY ./postfix/ /etc/postfix/
COPY mailname /etc/mailname

# Remove apenas os arquivos .conf padrões do Ubuntu para não chocar com os novos arquivos de configuração do Dovecot
RUN rm -f /etc/dovecot/conf.d/*.conf
COPY ./dovecot/ /etc/dovecot/conf.d/

# --- CORREÇÕES DE SINTAXE GARANTIDAS ---
RUN sed -i 's/disable_plaintext_auth.*/disable_plaintext_auth = no/g' /etc/dovecot/conf.d/10-auth.conf || true

# Copiando o script de usuários para uma pasta de execução
COPY mail.sh /usr/local/bin/mail.sh
RUN chmod +x /usr/local/bin/mail.sh

# Estrutura esqueleto para garantir que todo novo usuário criado já nasça com a pasta de e-mails pronta
RUN mkdir -p /etc/skel/Maildir/{cur,new,tmp} && chmod -R 700 /etc/skel/Maildir

# Portas 
EXPOSE 25/tcp
EXPOSE 587/tcp
EXPOSE 110/tcp
EXPOSE 143/tcp
EXPOSE 993/tcp
EXPOSE 995/tcp

# Área de persistência
VOLUME ["/var/mail/vmail"]

# Inicialização dos serviços
CMD ["sh", "-c", "/usr/local/bin/mail.sh ; service syslog-ng start ; service postfix start ; service dovecot start ; tail -F /var/log/mail.log"]