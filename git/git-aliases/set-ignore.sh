#!/bin/bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2026, Elijah Goossen ekgoossen@proton.me
# https://docs.gitignore.io/install/command-line

git config --global alias.ignore \
'!gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}; gi'
