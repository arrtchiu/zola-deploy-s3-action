#!/bin/bash
set -eo pipefail

zola build
pushd public
aws s3 sync . "s3://${BUCKET_NAME}"
