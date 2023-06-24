#!/usr/bin/env bash
# -*- coding: utf-8 -*-

source scripts/.denv

docker run --rm \
  -it \
  --name dev-env \
  --volume /var/run/docker.sock:/var/run/docker \
  ${DENV_IMAGE_NAME}:${DENV_IMAGE_TAG}
