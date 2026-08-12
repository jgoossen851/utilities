#!/bin/bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2026, Elijah Goossen ekgoossen@proton.me

echo '
# Add git branch to prompt
PS1="${PS1%\\\$*}\[\033[01;33m\]\$(__git_ps1 \" (%s)\")\[\033[00m\]\$ "' >> $HOME/.bashrc
