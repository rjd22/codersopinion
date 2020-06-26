#!/bin/bash

export JEKYLL_VERSION=4
docker run --rm \
  --env JEKYLL_UID=$UID \
  --publish 4000:4000 \
  --volume=$PWD:/srv/jekyll \
  -it jekyll/jekyll:$JEKYLL_VERSION \
  jekyll serve --drafts --watch
