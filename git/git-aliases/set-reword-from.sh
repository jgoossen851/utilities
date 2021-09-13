#!/bin/bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021, Jeremy Goossen jeremyg995@gmail.com

git config --global alias.reword-from '!f() { : git rebase ; \
        GET_HASH="\$(grep -o \"\w\{40\}\" .git/rebase-merge/done | tail -n1)"; \
        SET_COMMIT_DATE="GIT_COMMITTER_DATE=\"\$(git show -s --format=%ci $GET_HASH)\""; \
        COMMAND="$SET_COMMIT_DATE git commit --amend"; \
        git rebase -i --exec "$COMMAND" "$@"; \
    }; f'
