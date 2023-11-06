#!/bin/bash

# A generic build script for epics-containers ioc repositories
#
# Note that this is implemented in bash to make it portable between
# CI frameworks. This approach uses the minimum of GitHub Actions.
# Also works locally for testing outside of CI
#
# INPUTS:
#   PUSH: if true, push the container image to the registry
#   TAG: the tag to use for the container image
#   CACHE: the directory to use for caching

export EC_TAG="--tag ${TAG:-latest}"
export EC_CACHE="${CACHE:-/tmp/ec-cache}"
if [[ "${PUSH}" == 'true' ]] ; then EC_PUSH='--push' ; fi

set -xe
mkdir -p ${CACHE}

# get the current version of ec CLI
pip install -r $(dirname ${0})/../../requirements.txt

# add cache arguments - local file cache passed by github seems to be most reliable
export EC_CARGS="
    --cache-from type=local,src=${EC_CACHE}
    --cache-to type=local,dest=${EC_CACHE}
"

# build runtime and developer images
ec -v dev build ${EC_TAG} ${EC_PUSH} ${EC_CARGS} --suffix "" --target runtime


