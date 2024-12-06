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
