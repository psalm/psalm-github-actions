FROM ghcr.io/danog/psalm:latest

RUN apt-get update && apt-get -y install git openssh-client

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Satisfy Psalm's quest for a composer autoloader (with a symlink that disappears once a volume is mounted at /app)

RUN ln -s /composer/vendor/ /app/vendor

# Add entrypoint script

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Package container

WORKDIR "/app"
ENTRYPOINT ["/entrypoint.sh"]
