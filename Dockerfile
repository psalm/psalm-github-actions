FROM php:7.4-alpine

LABEL "com.github.actions.name"="Psalm"
LABEL "com.github.actions.description"="A static analysis tool for finding errors in PHP applications"
LABEL "com.github.actions.icon"="check"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="http://github.com/psalm/psalm-github-actions"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="Matt Brown <github@muglug.com>"

# Code borrowed from mickaelandrieu/psalm-ga which in turn borrowed from phpqa/psalm

# Install Tini - https://github.com/krallin/tini

RUN apk add --no-cache tini

COPY --from=composer:1.9 /usr/bin/composer /usr/bin/composer

RUN COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_HOME="/composer" \
    composer global config minimum-stability dev

RUN COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_HOME="/composer" \
    composer global require --prefer-dist --no-progress --dev vimeo/psalm:dev-master

ENV PATH /composer/vendor/bin:${PATH}

# Satisfy Psalm's quest for a composer autoloader (with a symlink that disappears once a volume is mounted at /app)

RUN mkdir /app && ln -s /composer/vendor/ /app/vendor

# Add entrypoint script

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Package container

WORKDIR "/app"
ENTRYPOINT ["/entrypoint.sh"]
