#!/bin/bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2022, Jeremy Goossen jeremyg995@gmail.com

git config --global alias.list-ignored '!f() { : git check-ignore ; \
        git check-ignore --verbose $( git status --ignored --untracked-files=all --porcelain | grep '"'"'!!\s'"'"' | cut -c4- ); \
    }; f'
