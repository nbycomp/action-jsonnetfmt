#!/bin/sh -l

cd "$GITHUB_WORKSPACE" || exit 1

find . \( -name '*.libsonnet' -o -name '*.jsonnet' \) -print0 |
    xargs -0 -- jsonnetfmt --test
