#!/bin/bash
set -eo pipefail

if ! [[ -z "${DISTRIBUTION_ID}" ]]; then
  set +eo pipefail
  INVALIDATE=$(git log -1 --pretty=%B | grep invalidate= | cut -d = -f2)
  set -eo pipefail
fi

zola build
pushd public
aws s3 sync . "s3://${BUCKET_NAME}"

if ! [[ -z "${INVALIDATE}" ]]; then
  aws cloudfront create-invalidation --distribution-id "${DISTRIBUTION_ID}" --paths "${INVALIDATE}"
fi
