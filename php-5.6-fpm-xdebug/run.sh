#!/usr/bin/env bash

docker run -p 9009:9000 --name=xdebug -v $(pwd):$(pwd) php-fpm-xdebug