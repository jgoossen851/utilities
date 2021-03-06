#!/bin/bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021, Jeremy Goossen jeremyg995@gmail.com

# Code for alias from StackOverflow: https://stackoverflow.com/a/54804224
git config --global alias.lfs-hard-checkout '!f() { \
        git rm --cached -r .; \
        git reset --hard; \
        git rm .gitattributes; \
        git reset .; \
        git checkout .; \
    }; f'
