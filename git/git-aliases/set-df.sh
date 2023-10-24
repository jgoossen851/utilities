#!/bin/bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021, Jeremy Goossen jeremyg995@gmail.com

git config --global alias.df "diff --word-diff --ignore-space-change"

# Divide words on the following punctuation in addition to spaces:
#   , ; : + = ' " & | < >
git config --global alias.on 'diff --color-words="[^[:space:],;:\\+=\\'\''\\\"&|<>]+|[^[:space:]+]" --ignore-space-change'

git config --global color.diff.meta "magenta"
git config --global color.diff.func "bold"
git config --global color.diff.old "reverse dim red red"
git config --global color.diff.new "reverse dim green green"
git config --global color.diff.whitespace "reverse bold red red"
git config --global color.diff.oldMoved "dim cyan"
git config --global color.diff.newMoved "bold cyan"
git config --global color.diff.oldMovedAlternative "dim yellow"
git config --global color.diff.newMovedAlternative "bold yellow"
