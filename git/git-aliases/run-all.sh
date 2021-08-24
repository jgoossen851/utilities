#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

for FILE in $SCRIPT_DIR/set-*.sh; do
  bash "$FILE"
done

