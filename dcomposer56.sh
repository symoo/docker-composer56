#!/usr/bin/env sh
docker run --rm -it \
--init \
-v $PWD:/app \
-v ~/.composer/cache/:/root/.composer/cache/ \
symo/composer56 $@