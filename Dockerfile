FROM ubuntu:16.04
MAINTAINER Ernestas Poskus <hierco@gmail.com>

# Install dependencies.
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    python-software-properties \
    software-properties-common \
    rsyslog systemd systemd-cron sudo \
    iproute curl

RUN apt-get install -y python3-pip python3-dev

RUN pip3 install --upgrade pip

RUN pip3 install ansible \
    && rm -Rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man

RUN apt-get clean
RUN sed -i 's/^\($ModLoad imklog\)/#\1/' /etc/rsyslog.conf

# Install/prepare Ansible
RUN mkdir -p /etc/ansible/roles
RUN mkdir -p /opt/ansible/roles
RUN rm -f /opt/ansible/hosts
RUN printf '[local]\nlocalhost ansible_connection=local\n' > /etc/ansible/hosts
