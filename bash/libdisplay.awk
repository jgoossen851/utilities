# Format the input string using ANSI escape sequences
# The following formatting characters are replaced in the input:
#   **  Toggle Bold
#   ##  Toggle Faint
#   __  Toggle Italics
#   ||  Toggle Underline
#   @@  Toggle Inverse
#   ~~  Toggle Strikethrough
#   {n; Set foreground color to n (n = 0 - 7)
#   }   Default foreground color
#   [n; Set background color to n (n = 0 - 7)
#   ]   Default background color
#             0: Black  1: Red      2: Green  3: Yellow
#             4: Blue   5: Magenta  6: Cyan   7: White
#   !   Do not use the following character for formatting [escape character]

{
  split($0, chars, "")
  for (i=1; i <= length($0); i++) {
    if ( chars[i]=="*" && chars[i+1]=="*" ) { printf("\\e[%dm", (bold=!bold) == 1 ? 1 : 22); i++ }
    else if ( chars[i]=="#" && chars[i+1]=="#" ) { printf("\\e[%dm", (dim=!dim) == 1 ? 2 : 22); i++ }
    else if ( chars[i]=="_" && chars[i+1]=="_" ) { printf("\\e[%dm", (ital=!ital) == 1 ? 3 : 23); i++ }
    else if ( chars[i]=="|" && chars[i+1]=="|" ) { printf("\\e[%dm", (undr=!undr) == 1 ? 4 : 24); i++ }
    else if ( chars[i]=="@" && chars[i+1]=="@" ) { printf("\\e[%dm", (invs=!invs) == 1 ? 7 : 27); i++ }
    else if ( chars[i]=="~" && chars[i+1]=="~" ) { printf("\\e[%dm", (strk=!strk) == 1 ? 9 : 29); i++ }
    else if ( chars[i]=="{" && chars[i+2]==";" ) { printf("\\e[3%dm", chars[++i]); i++ }
    else if ( chars[i]=="}" ) { printf("\\e[39m") }
    else if ( chars[i]=="[" && chars[i+2]==";" ) { printf("\\e[4%dm", chars[++i]); i++ }
    else if ( chars[i]=="]" ) { printf("\\e[49m") }
    else { if ( chars[i]=="!" ) { i++ }; printf("%s", chars[i]) }
  }
}
