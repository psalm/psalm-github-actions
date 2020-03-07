#!/bin/sh -l
set -e

sh -c "composer install --no-scripts --no-progress && /composer/vendor/bin/psalm --version && /composer/vendor/bin/psalm  --output-format=github $*"
