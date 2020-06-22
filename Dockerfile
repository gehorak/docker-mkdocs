# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:alpine

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1
# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1

# Base packages:
RUN apk add --update --no-cache \
    curl \
    wget \   
    git \
    unzip \
    tar \ 
    bash \
    openssh \
    && rm -rf /var/cache/* /var/tmp/* /tmp/* \
    && mkdir /var/cache/apk 

# Install pip requirements
ADD requirements.txt .

# Install dev libraries for Python library, ...
RUN apk add --update --no-cache --virtual .build-deps \
    python3-dev \
    py3-pip \
    gcc \
    musl-dev \
    #build-base \
    && python -m pip install --no-cache-dir -r requirements.txt \
    && apk del .build-deps \
    && rm -rf /var/cache/* /var/tmp/* /tmp/* \
    && mkdir /var/cache/apk 

# Switching to a non-root user, please refer to https://aka.ms/vscode-docker-python-user-rights
#RUN useradd appuser && chown -R appuser /app
#USER appuser

WORKDIR /mkdocs
ADD . /mkdocs

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]