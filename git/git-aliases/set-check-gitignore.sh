#!/bin/bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2023, Jeremy Goossen jeremyg995@gmail.com

# Set alias name from file name
ALIAS="$(echo "${0}" | sed -E 's|^.*set-([^/]*).sh$|\1|')"

git config --global alias."${ALIAS}" '!f() { : git check-ignore ; \
    echo -e "Ignored files and directories:\n"
    git check-ignore --verbose $( git clean --dry-run -dX | sed '"'"'s/Would remove //'"'"' ) | \
      column -t ; \
    echo -e "\nTracked files matching an ignore pattern:\n" ;
    git check-ignore --no-index --verbose $( git ls-files -i --exclude-standard ) | \
      column -t ;
  }; f'
