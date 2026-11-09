FROM python:3.11-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libkrb5-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    ansible-core \
    ansible-lint \
    pywinrm \
    pywinrm[credssp] \
    requests-ntlm

# Adicionada a colecao community.general
RUN ansible-galaxy collection install ansible.windows community.windows community.general -p /usr/share/ansible/collections

WORKDIR /ansible


ENTRYPOINT ["ansible-playbook"]
