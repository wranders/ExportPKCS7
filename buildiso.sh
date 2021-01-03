#!/bin/sh

genisoimage \
    -input-charset utf-8 \
    -m .git \
    -m .gitignore \
    -m buildiso.sh \
    -m Dockerfile \
    -m ExportPKCS7.iso \
    -m README.md \
    -iso-level 3 \
    -o ExportPKCS7.iso \
    $PWD
