# 🚀 NexusTech Enterprise Infrastructure

> Documentação Técnica & Guia de Apresentação

---

# 📌 Sobre o Projeto

Este projeto consiste em uma infraestrutura corporativa integrada, resiliente e totalmente conteinerizada utilizando Docker Compose.

O ambiente simula com fidelidade o ecossistema tecnológico de uma empresa real (**NexusTech**), dispondo de:

* Servidor DNS autônomo
* Servidor de e-mails com persistência de dados
* Aplicações web segregadas por setores
* Proxy Reverso unificado para segurança e roteamento

---

# 🏗️ Arquitetura do Ecossistema Web

Toda a comunicação HTTP externa é centralizada em um único ponto de entrada: o **Proxy Reverso Nginx**.

O proxy analisa o cabeçalho `Host` da requisição e encaminha o tráfego para o container correto através da rede privada `nexustech-network`.

## Fluxo de Comunicação

```text
Usuário → Proxy Reverso Nginx → Serviço Interno Correspondente
```

## Mapeamento dos Serviços

| Endereço Virtual                  | Container          | Finalidade                    |
| --------------------------------- | ------------------ | ----------------------------- |
| `http://nexustech.com.br`         | `c001-web-main`    | Site institucional principal  |
| `http://portal.nexustech.com.br`  | `c002-web-portal`  | Portal interno administrativo |
| `http://suporte.nexustech.com.br` | `c003-web-suporte` | Central de suporte técnico    |

---

# 📂 Estrutura de Diretórios

```text
nexustech-infra/
├── compose.yml
├── dns/
│   └── Configurações do servidor DNS Bind9
│
├── mail/
│   └── Servidor de e-mail (Postfix + Dovecot)
│
├── proxy/
│   └── Configurações do Proxy Reverso Nginx
│
└── web/
    ├── site-main/
    │   └── Site institucional principal
    │
    ├── site-portal/
    │   └── Portal corporativo administrativo
    │
    └── site-suporte/
        └── Central de suporte técnico
```

---

# ⚙️ Tecnologias Utilizadas

## 🌐 Nginx

Utilizado de forma descentralizada:

* 1 instância atuando como **Proxy Reverso**
* 3 instâncias independentes servindo aplicações web

Responsável por:

* Balanceamento e roteamento
* Virtual Hosts
* Segurança de borda
* Reverse Proxy

---

## 🧭 Bind9 DNS

Servidor DNS autoritativo configurado para a zona:

```text
nexustech.com.br
```

Operando nas portas:

* TCP 53
* UDP 53

---

## 📧 Postfix + Dovecot

Stack completa de e-mail corporativo responsável por:

* SMTP (envio/recebimento)
* IMAP
* POP3
* Persistência de caixas postais

Volumes persistentes utilizados:

```text
mail_data/
```

---

# 🚀 Como Executar o Ambiente

Antes de iniciar o ambiente, clone o projeto da infraestrutura para sua máquina local utilizando o Git.

## 1️⃣ Clonar o Repositório

Execute o comando abaixo no terminal:

```bash
git clone https://github.com/Juliocesar1704/Servidor_de_email.git

## 2️⃣ Inicializar os Containers

Na raiz do projeto: /nexustech-infra

```bash
docker compose up -d --build
```

---

## 3️⃣ Validar o Ambiente

Verifique se todos os containers estão em execução:

```bash
docker compose ps
```

---

# 🔎 Testando o Projeto

Após subir os containers, acesse:

| Serviço               | URL                               |
| --------------------- | --------------------------------- |
| Site principal        | `http://nexustech.com.br`         |
| Portal administrativo | `http://portal.nexustech.com.br`  |
| Central de suporte    | `http://suporte.nexustech.com.br` |

---

# 🛡️ Conceitos Aplicados

## 🔒 Segurança de Perímetro

Os containers web internos **não expõem portas diretamente** para a máquina host.

Apenas o Proxy Reverso possui acesso externo pela porta:

```text
80/tcp
```

---

## 🧩 Arquitetura de Micro-serviços

Cada setor da empresa possui:

* Container próprio
* Aplicação independente
* Isolamento de serviços
* Facilidade de manutenção

---

## 🌐 Rede Privada Docker

Todos os serviços se comunicam pela rede interna:

```text
nexustech-network
```

Garantindo:

* Isolamento
* Segurança
* Comunicação privada entre containers

---


# 👨‍💻 Autor

*Júlio César*
Projeto acadêmico de Infraestrutura Corporativa utilizando Docker Compose.
