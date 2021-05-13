#!/bin/sh -l

if [ -z "$GITHUB_WORKSPACE" ]; then
    printf '\e[33mGITHUB_WORKSPACE must be set\e[39m\n'
    exit 1
fi

if ! cd "$GITHUB_WORKSPACE"; then
    printf '\e[33mfailed to cd into $GITHUB_WORKSPACE\e[39m\n'
    exit 2
fi

find . \( -name '*.libsonnet' -o -name '*.jsonnet' \) -print0 |
    xargs -0 -n 1 -I {} -- sh -c \
    'printf "checking %s: " "$0"
    if jsonnetfmt --test "$0"; then
        printf "\e[32mpassed\e[39m\n"
    else
        printf "\e[31mfailed\e[39m\n"
        exit 1
    fi' {}
