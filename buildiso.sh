#!/bin/sh

genisoimage \
    -input-charset utf-8 \
    -m buildiso.sh \
    -m ExportPKCS7.iso \
    -iso-level 3 \
    -o ExportPKCS7.iso \
    $PWD
