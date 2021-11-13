#!/bin/bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021, Jeremy Goossen jeremyg995@gmail.com

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# The above command is a useful header line to include in a script
# when you need to programatically determine the script's location
# at the time it is called.
# Run this script to copy the command to the clipboard.

case "$(uname -s)" in
    Linux*)     arch=Linux;     CLIPBOARD="xclip -sel clip";;
    # Darwin*)    arch=Mac;;
    # CYGWIN*)    arch=Cygwin;;
    MINGW*)     arch=MinGW;     CLIPBOARD="clip";;
    *)          arch=unknown;   echo "ERROR: Unknown architecture."; exit
esac

THIS_FILE="$SCRIPT_DIR/$(basename "${BASH_SOURCE[0]}")" # Get the full path to this file
COMMAND="$(sed '9!d' $THIS_FILE)"                       # Save line 9 of this file
echo -n $COMMAND | $CLIPBOARD                           # Copy the line to the clipboard
echo -e "Copied \033[0;36m$COMMAND\033[0m to clipboard."
