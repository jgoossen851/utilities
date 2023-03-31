#!/bin/bash

# Unzip the file, replacing backslash and null characters
CONTENTS="$(unzip -c "${1}" | sed 's/\\/\\\\/g' | sed 's/\x0/\\0'/g)"
# Get line numbers of file names
FILE_LIST="$(echo "${CONTENTS}" | grep -naP "^\s+inflating:\s")"
# Get line numbers where files end
END_COL="$(echo -e "${FILE_LIST}\n$(( $(wc -l <(echo "${CONTENTS}") | grep -Po "^\d+") + 1))" | grep -Po "^\d+" | tail +2)"
# Combine columns and sort list by column name
SORT_LIST="$(paste <(echo "${FILE_LIST}") <(echo "${END_COL}") | sort -k3,3 -b)"
# Rewrite unzipped data in order
head -n1 <(echo "${CONTENTS}")
while read -ra LINE; do
  # Print the contents, starting at ${LINE[0]//:} and ending at $(( "${LINE[3]}" - 1 ))
  echo "${CONTENTS}" | sed -n "${LINE[0]//:},$(( "${LINE[3]}" - 1 )) p"
done < <(echo "${SORT_LIST}")

exit





exit






# Unzip the file 
unzip -c "${1}" > stage

# Get line numbers of file names
FILE_LIST="$(cat stage | grep -naP "^\s+inflating:\s")" #; echo "${FILE_LIST}"
# Get line numbers where files end
END_COL="$(echo -e "${FILE_LIST}\n$(( $(wc -l stage | grep -Po "^\d+") + 1))" | grep -Po "^\d+" | tail +2)" #; echo "${END_COL}"
# Combine columns and sort list by column name
SORT_LIST="$(paste <(echo "${FILE_LIST}") <(echo "${END_COL}") | sort -k3,3 -b)"
# Rewrite unzipped data in order

head -n1 stage > stage2
while read -ra LINE; do
  #echo Line is "${LINE[2]}"
  #echo File is "${LINE[2]}"
  #echo Start is $(( "${LINE[0]//:}" + 1))
  #echo End is $(( "${LINE[3]}" - 1 ))
  
  sed -n "${LINE[0]//:},$(( "${LINE[3]}" - 1 )) p" stage >> stage2
  
  
  
  #sed -n "$(( "${LINE[0]//:}" + 1)),$(( "${LINE[3]}" - 1 )) p" stage > "zip/${LINE[2]}"
  
  #mkdir -p "zip/$(dirname ${LINE[2]})"
  #sed -n "$(( "${LINE[0]//:}" + 1)),$(( "${LINE[3]}" - 1 )) p" stage > "zip/${LINE[2]}"


  #echo Line is "${LINE}"
  #FILE="$(echo "${LINE}" | awk '{print $3}')"
  #echo File is "${FILE}"
  #START="$(echo "${LINE}" | awk '{print $1}')"
  #echo Start is "${START}"
  ##END="$(echo "${LINE}" | awk '{print $4}')"
  #END="$(echo "${LINE}" | grep -Po '\d+$')"
  #echo End is "${END}"
  
  
  #echo "${LINE}" | awk '{print $2}'
  
  
done < <(echo "${SORT_LIST}")

exit


for LINE in ${SORT_LIST}; do
  echo Line is "${LINE}"
done



echo "${FILE_LIST}" | sed 's/$/\tgreen/'


 | sort -k3,3 -b



 | grep -Po "^\d+"
