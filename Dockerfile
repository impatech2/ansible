FROM python:3.11-slim

# Instala dependências de sistema necessárias para WinRM e Kerberos/NTLM
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libkrb5-dev \
    && rm -rf /var/lib/apt/lists/*

# Instala o Ansible Core e bibliotecas de conexão Windows
RUN pip install --no-cache-dir \
    ansible-core \
    pywinrm \
    pywinrm[credssp] \
    requests-ntlm

# Instala as coleções do Ansible para Windows
RUN ansible-galaxy collection install ansible.windows community.windows

WORKDIR /ansible

ENTRYPOINT ["ansible-playbook"]
