#!/bin/bash

# Criando a pasta raiz onde todos os e-mails ficarão centralizados para persistência
mkdir -p /var/mail/vmail

# Função em bloco para criar o usuário apenas se ele não existir no sistema
criar_usuario() {
    local user=$1
    local name=$2
    if ! id "$user" &>/dev/null; then
        # Define a home do usuário dentro da pasta que será persistida
        # Adicionado "|| true" para ignorar se o Linux reclamar do chown automático do useradd no volume
        useradd -c "$name" -d /var/mail/vmail/$user -m -s /bin/false "$user" || true
        echo "$user:123456" | chpasswd
    fi
}

# Criando as contas solicitadas passando os parâmetros para o bloco
criar_usuario "admin_nx" "admin_nx"
criar_usuario "suporte_nx" "suporte_nx"
criar_usuario "financeiro_nx" "financeiro_nx"
criar_usuario "contato_nx" "contato_nx"

# Ajustando permissões - Adicionado "|| true" no final de cada uma para o Docker Desktop não travar o script
chown -R mail:mail /var/mail/vmail || true
chmod -R 770 /var/mail/vmail || true