#!/usr/bin/env bash
# -*- coding: utf-8 -*-

source scripts/.denv

docker run --rm \
  --name denv \
  -it \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  ${DENV_IMAGE_NAME}:${DENV_IMAGE_TAG}
