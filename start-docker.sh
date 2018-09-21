#!/bin/bash

docker run --name serverload -d -v /tmp:/tmp --restart unless-stopped oskarv/serverload
