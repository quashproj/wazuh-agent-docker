FROM debian:12-slim

ARG WZ_VERSION_ARG

LABEL maintainer "sgonzalezoyuela@gmail.com"
LABEL version ${WZ_VERSION_ARG}
LABEL description "A3C SOC - Wazuh Agent"

ENV WZ_VERSION=${WZ_VERSION_ARG}

RUN apt-get update -y
RUN apt-get install -y procps curl apt-transport-https gnupg2 inotify-tools

RUN curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add - && \
  echo "deb https://packages.wazuh.com/4.x/apt/ stable main" | tee /etc/apt/sources.list.d/wazuh.list
RUN apt-get update -y

# Wazuh agent
RUN echo WZ_VERSION=$WZ_VERSION
RUN apt-get install -y wazuh-agent=$WZ_VERSION

COPY entrypoint.sh ossec.conf /

RUN mv /ossec.conf /var/ossec/etc/
RUN rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/entrypoint.sh"]
