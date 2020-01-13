#!/usr/bin/env bash

### Run like so:
# FILE=openapi.json OUTPUT=/tmp/test ./generate_client.sh
# the openapi schema needs to be in this directory for the container to see it.
# the OUTPUT var is mounted in the container - so if you want it in the current directory
# it would have to be something like /workdir/output

docker run -it --rm \
    -v /tmp:/tmp \
    -v $PWD:/workdir \
    openapitools/openapi-generator-cli \
    generate -i /workdir/$FILE -g ruby -o $OUTPUT -c /workdir/config.json

echo -e "=======
Client generated from $FILE in: $OUTPUT
======="
