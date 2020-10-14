# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.8-alpine

LABEL name=gehorak/mkdocs
LABEL version=0.0.2
LABEL description="Docker image with MkDocs and Material theme plugin inside."

# Version of MkDocs:
ENV MKDOCS_VERSION 1.1.2
# Install Plugins for MkDocs:
ARG WITH_PLUGINS=true

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1
# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1

# Add file with python requrements:
ADD requirements.txt .

# Base packages:
RUN set -x && \
    \
    echo "==> Base package install..."  && \
    apk add --update --no-cache \
    bash \
    ca-certificates \
    curl \
    git \
    openssh \
    sshpass \
    tar \ 
    unzip \
    wget \
    && \
    rm -rf /var/cache/* /var/tmp/* /tmp/* && \
    mkdir /var/cache/apk 

# Install dev libraries for Python ...
RUN set -x && \
    \
    echo "==> Adding temporary Build-dependencies..." && \
    apk --update add --no-cache --virtual .build-dependencies \
    gcc \
    musl-dev \
    python3-dev \
    py3-pip \
    openssl-dev && \
# Install pip packages ...
#RUN set -x && \
    \
    echo "==> Python pip package install......"  && \
    python -m pip install --upgrade pip && \   
## Install core MkDocs without plugins with python pip ...
#RUN set -x && \
    \
    echo "==> Installing MkDocs core without plugins..."  && \
    python -m pip install mkdocs==${MKDOCS_VERSION} && \
## Install mkdocs with pip requirements.txt ...
#RUN set -x && \
    \
    echo "==> Installing MkDocs with plugins..."  && \
    if [ "$WITH_PLUGINS" = "true" ] ; then \
    python -m pip install --no-cache-dir -r requirements.txt; \
    else echo 'Instaling without plugins'; \
    fi &&\
#    python -m pip install --no-cache-dir -r requirements.txt && \

## Cleaning up Build-dependencies 
#RUN set -x && \
    \
    echo "==> Cleaning up Build-dependencies ..."  && \
    apk del .build-dependencies && \
    rm -rf /var/cache/apk/* /var/tmp/* /tmp/* 

# Switching to a non-root user, please refer to https://aka.ms/vscode-docker-python-user-rights
#RUN useradd appuser && chown -R appuser /app
#USER appuser

WORKDIR /mkdocs

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
