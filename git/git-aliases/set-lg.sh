#!/bin/bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021, Jeremy Goossen jeremyg995@gmail.com

git config --global alias.lg '!f() { : git log ; \
        LOG_LINE_LENGTH=$((`tput cols`-25)); \
        FORMAT_STRING='"'"'%C(yellow)%h%Creset %C(bold blue)<%an>%Creset %C(auto)%d%Creset %<|('"'"'$LOG_LINE_LENGTH'"'"',trunc) %s %Cgreen(%cr)'"'"'; \
        git log --graph --abbrev-commit --date=relative --all --max-count=35 --pretty=format:"$FORMAT_STRING" "$@"; \
    }; f'
