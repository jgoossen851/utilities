#!/bin/bash

while read -r FILE; do

  EXT="${FILE##*.}"

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

  echo "Processing ${FILE}"
  # Add a single space after any comment character, $CMT
  # Regex ensures that an even number of quote characters (' or ") appear before
  # the comment character, such that these comment characters are not formatted
  # within quoted strings. (No distiction is made between ' and ". A line with
  # both characters may not parse correctly.)
  # Only the last matching occurance per line will be replaced.
  QUOTE_RX="[\"'][^\"']*[\"']" # Matches any two quote characters and all characters between them
  NQ_RX="[^\"']*?" # Matches (non-greedy) anything except a quote character
  COMMENT_SPACE_RX="s/^((${NQ_RX}${QUOTE_RX})*?${NQ_RX}${CMT}+)\s?/\1 /"

  # Remove a trailing space from each line
  TRAILING_SPACE_RX="s/\s+$//"

  # Convert tabs to spaces
  TABS_TO_SPC_RX="s/\t/  /g"

  SKIP_PATTERNS="(http|#!\/)" # Skip lines if these patterns found
  sed -i -E "${TABS_TO_SPC_RX}; ${TRAILING_SPACE_RX}; /${SKIP_PATTERNS}/n; ${COMMENT_SPACE_RX}" "${FILE}"

done < <(git ls-files)
