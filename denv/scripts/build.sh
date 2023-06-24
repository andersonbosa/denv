#!/usr/bin/env bash
# -*- coding: utf-8 -*-

source scripts/.denv

docker build -t ${DENV_IMAGE_NAME}:${DENV_IMAGE_TAG} .
