#!/bin/bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2023, Jeremy Goossen jeremyg995@gmail.com

# Run this script in a Git directory to run linter on all files tracked by Git

# Linter will not run textual replacement on any line containing a pattern
# listed below, though whitespace may still be formatted.
SKIP_PATTERNS="(nolint|http|#!\/)" # Skip lines if these patterns found

# ANSI Escape Codes
CLEAR_LINE="\e[1G\e[2K" # Cursor to column 1 and clear entire line

while read -r FILE; do

  # Parse file extension, defining language-specific syntax and skipping any
  # unknown file extensions
  EXT="${FILE##*.}" # Strip everything before the last period, inclusive
  case "${EXT}" in
    gitignore | py | sh)
        CMT="#"
        ;;
    m)
        CMT="%"
        ;;
    *)
        CMT=""
        continue ;;
  esac

  # Display Status if file extension is known
  echo -en "${CLEAR_LINE}Processing ${FILE}"

  # Add a single space after any (unquoted) comment character, $CMT
  # Regex ensures that an even number of quote characters (' or ") appear before
  # the comment character, such that these comment characters are not formatted
  # within quoted strings. (No distiction is made between ' and ". A line with
  # both characters may not parse correctly.)
  # Only the last matching occurance per line will be replaced.
  QUOTE_RX="[\"'][^\"']*[\"']" # Matches any two quote characters and all characters between them
  NQ_RX="[^\"']*?" # Matches (non-greedy) anything except a quote character
  COMMENT_SPACE_RX="s/^((${NQ_RX}${QUOTE_RX})*?${NQ_RX}${CMT}+)\s?/\1 /"

  # Add single space after all commas for better readability
  COMMA_SPACE_RX="s/,\s*/, /g" # nolint

  # Remove any trailing space from each line (cannot be skipped)
  TRAILING_SPACE_RX="s/\s+$//"

  # Convert all tabs to 2 spaces (cannot be skipped)
  TABS_TO_SPC_RX="s/\t/  /g"

  # Ensure all files end with a final newline
  FINAL_NEWLINE_RX='$a\' # (Append nothing to end of line, adding missing newlines in the process)

  # Run the SED command - whitespace is processed before Skip Patterns are read
  # Trailing Spaces are matched twice - once before any patterns trigger the
  # rest of the expression to be skipped, and once at the end to remove spaces
  # added after comments and commas.
  sed -i -E "${TABS_TO_SPC_RX}; ${TRAILING_SPACE_RX}; /${SKIP_PATTERNS}/n; ${COMMA_SPACE_RX}; ${COMMENT_SPACE_RX}; ${TRAILING_SPACE_RX}; ${FINAL_NEWLINE_RX}" "${FILE}"

  if [[ "${OSTYPE}" == "msys" ]]; then
    # Restore line-endings on Windows
    unix2dos -q "${FILE}"
  fi

done < <(git ls-files)

echo # Final newline after status output
