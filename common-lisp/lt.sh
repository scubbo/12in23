#!/bin/bash

# "Lisp Test"
# Runs the tests from the directory where it's invoked (i.e. call this as `../lt.sh`)
# You still need to "Ctrl+D" to exit the REPL, I haven't figured out how to automate that

EXERCISE_NAME=$(basename $(pwd))
# https://stackoverflow.com/a/9547484/1040915
cmd=(--noinform --load "$EXERCISE_NAME-test.lisp" --eval "(""$EXERCISE_NAME""-test:run-tests)")
sbcl "${cmd[@]}"
