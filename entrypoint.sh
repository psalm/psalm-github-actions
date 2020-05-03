#!/bin/sh -l
set -e

COMPOSER_COMMAND="composer install --no-scripts --no-progress"
echo "::group::$COMPOSER_COMMAND"
$COMPOSER_COMMAND
echo "::endgroup::"

/composer/vendor/bin/psalm --version
/composer/vendor/bin/psalm --output-format=github $*
