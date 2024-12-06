#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

function display () {
  echo -e "$(awk -f ${SCRIPT_DIR}/libdisplay.awk <<<"${1}")"
}


# ### Testing output
# display "Test **Bold** __Ita!*lic__ ||Underlined|| ##dim## @@inverse@@ ~~striked~~ {3;text}"
# display "Test **Bold and __Italic__ ||Under**lined|| ##dim @@i~~nv##erse@@ st**riked~~ tex**t"
# display "{1;Critical **Error**:} ##This __is__ an ~~error~~.## ||{3;__You__} [4;**should] @@fix@@ it||"

### Previous implementations

function display_sed () {
  # Print text with formatting:
  #   *...*  Bold
  #   _..._  Italic
  #   ~...~  Strikethrough
  #   |...|  Underline
  #   @...@  Inverse
  #   #...#  Dim
  #   n{..}  Foreground Color #n (n = 0 - 7)
  #   n[..]  Background Color #n (n = 0 - 7)
  #             0: Black  1: Red      2: Green  3: Yellow
  #             4: Blue   5: Magenta  6: Cyan   7: White

  echo -e "$(sed -E -e "s/\*([^*]*)\*/\\\\e[1m\1\\\\e[22m/g" \
      -e "s/#([^#]*)#/\\\\e[2m\1\\\\e[22m/g" \
      -e "s/_([^_]*)_/\\\\e[3m\1\\\\e[23m/g" \
      -e "s/\|([^|]*)\|/\\\\e[4m\1\\\\e[24m/g" \
      -e "s/@([^@]*)@/\\\\e[7m\1\\\\e[27m/g" \
      -e "s/~([^~]*)~/\\\\e[9m\1\\\\e[29m/g" \
      -e "s/([0-7])\{([^}]*)\}/\\\\e[3\1m\2\\\\e[39m/g" \
      -e "s/([0-7])\[([^]]*)\]/\\\\e[4\1m\2\\\\e[49m/g" <<< "${1}")"
}


function display_awk () {
  # Print text with formatting:
  #   *...*  Bold
  #   _..._  Italic
  #   ~...~  Strikethrough
  #   |...|  Underline
  #   @...@  Inverse
  #   #...#  Dim
  #   n{..}  Foreground Color #n (n = 0 - 7)
  #   n[..]  Background Color #n (n = 0 - 7)
  #             0: Black  1: Red      2: Green  3: Yellow
  #             4: Blue   5: Magenta  6: Cyan   7: White
  #   !.     Escape character: Do not use the following character for formatting

  echo -e "$(echo "${1}" | awk '
  {
    bold=0
    dim=0
    ital=0
    undr=0
    invs=0
    strk=0
    split($0, chars, "")
    for (i=1; i <= length($0); i++) {
      if ( chars[i]=="*" ) { printf("\\e[%dm", (bold=!bold) == 1 ? 1 : 22) }
      else if ( chars[i]=="#" ) { printf("\\e[%dm", (dim=!dim) == 1 ? 2 : 22) }
      else if ( chars[i]=="_" ) { printf("\\e[%dm", (ital=!ital) == 1 ? 3 : 23) }
      else if ( chars[i]=="|" ) { printf("\\e[%dm", (undr=!undr) == 1 ? 4 : 24) }
      else if ( chars[i]=="@" ) { printf("\\e[%dm", (invs=!invs) == 1 ? 7 : 27) }
      else if ( chars[i]=="~" ) { printf("\\e[%dm", (strk=!strk) == 1 ? 9 : 29) }
      else if ( chars[i]=="{" && chars[i+2]==";" ) { printf("\\e[3%dm", chars[++i]); i++ }
      else if ( chars[i]=="}" ) { printf("\\e[39m") }
      else if ( chars[i]=="[" && chars[i+2]==";" ) { printf("\\e[4%dm", chars[++i]); i++ }
      else if ( chars[i]=="]" ) { printf("\\e[49m") }
      else { if ( chars[i]=="!" ) { i++ }; printf("%s", chars[i]) }
    }
  }')"
}
