#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

function display () {
  echo -e "$(awk -f ${SCRIPT_DIR}/libdisplay.awk <<<"${1}")"
}

# ### Sample help text
# display "Interpret special characters in input as ANSI formatting strings"
# display "  !**  toggles **bold** text."
# display "  !##  toggles ##dim## text."
# display "  !__  toggles __italic__ text."
# display "  !||  toggles ||underlined|| text."
# display "  !@@  toggles @@inverse@@ text."
# display "  !~~  toggles ~~strikethrough~~ text."
# display "  !{__n__; changes the {1;foreground color}; See below for value of __n__."
# display "  !}   resets the foreground color to default value"
# display "  ![__n__; changes the [1;background color]; See below for value of __n__."
# display "  !]   resets the background color to default value"
# display "  !!   Escape character: prevents the following character from being interpreted."
# display "           (Use **!!!!** to output a literal exclaimation mark.)"
# display "Color specifiers (valid values for __n__)"
# display "    0: [0;Black]  1: {1;Red}      2: {2;Green}  3: {3;Yellow}"
# display "    4: [4;Blue]   5: {5;Magenta}  6: {6;Cyan}   7: {7;White}"

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
