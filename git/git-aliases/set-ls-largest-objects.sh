#!/bin/bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2023, Jeremy Goossen jeremyg995@gmail.com

# Set alias name from file name
ALIAS="$(echo "${0}" | sed -E 's|^.*set-([^/]*).sh$|\1|')"

git config --global alias."${ALIAS}" '!f() { : head -n ; \
        git rev-list --objects --all \
          | git cat-file --batch-check='"'"'%(objecttype) %(objectname) %(objectsize) %(rest)'"'"' \
          | sed -n '"'"'s/^blob //p'"'"' \
          | sort --numeric-sort --key=2 --reverse \
          | head -n ${1:-20} \
          | cut -c 1-12,41- \
          | $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest ; \
    }; f'
