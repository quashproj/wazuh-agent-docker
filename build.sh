#!/usr/bin/env bash

export WZ_VERSION=4.7.3-1

echo building for Wazuh version "$WZ_VERSION"

docker build \
	--build-arg WZ_VERSION_ARG="$WZ_VERSION" \
	-t quashprj/soc-wazuh-agent:"$WZ_VERSION" .
