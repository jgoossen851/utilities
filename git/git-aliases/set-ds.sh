#!/bin/bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021, Jeremy Goossen jeremyg995@gmail.com

git config --global alias.ds "diff --word-diff --ignore-space-change --cached"

# Divide words on the following punctuation in addition to spaces:
#   , ; : + = ' " & | -
git config --global alias.in 'diff --color-words="[^[:space:],;:\\+=\\'\''\\\"&|-]+|[^[:space:]+]" --ignore-space-change --cached'
