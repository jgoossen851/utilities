#!/bin/bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2023, Jeremy Goossen jeremyg995@gmail.com

git config --global alias.swap-parents '!f() { : git reset ; \
        git reset --soft $(git show --format="%B" HEAD | git commit-tree -p HEAD^2 -p HEAD^1 "HEAD^{tree}") "$@"; \
    }; f'
