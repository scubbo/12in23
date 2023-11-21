#!/usr/bin/env bash

# If tests fail on a Mac, do:
# $ brew install coreutils
# then use `gdate`

 main() {
    start=$(TZ=UTC date -d "$1" +%s)
    result=$((start + 1000000000))
    TZ=UTC date -d "@$result" +%Y-%m-%dT%H:%M:%S
 }

 main "$@"