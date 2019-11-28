FROM debian:stretch-slim

LABEL "com.github.actions.name"="Zola Deploy to S3"
LABEL "com.github.actions.description"="Build and deploy a Zola site to S3"
LABEL "com.github.actions.icon"="zap"
LABEL "com.github.actions.color"="green"

# Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get update && apt-get install -y wget git python3
RUN wget -q -O - \
"https://github.com/getzola/zola/releases/download/v0.9.0/zola-v0.9.0-x86_64-unknown-linux-gnu.tar.gz" \
| tar xzf - -C /usr/local/bin
RUN pip3 install awscli --upgrade --user

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
