#!/bin/bash

useradd -c 'admin_nx' -m -s /bin/false admin_nx
echo "admin_nx:123456" | chpasswd

useradd -c 'suporte_nx' -m -s /bin/false suporte_nx
echo "suporte_nx:123456" | chpasswd

useradd -c 'financeiro_nx' -m -s /bin/false financeiro_nx
echo "financeiro_nx:123456" | chpasswd

useradd -c 'contato_nx' -m -s /bin/false contato_nx
echo "contato_nx:123456" | chpasswd