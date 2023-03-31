#!/bin/bash

#echo "Zip ${@}" >> filename.txt

# Pass over the null option "--"
if [ "${1}" = "--" ]; then
  shift
fi

# Get input from stdin
INPUT="$(cat)"

# Output file as-is
#  echo "${INPUT}" > raw

#TARGET=""
if [ "$(head -c 2 <(echo "${INPUT}"))" = "Ar" ]; then
  # while read -r LINE; do
  #   # Make the directory for the file
  #   if [[ "${LINE}" =~ 'Archive:' ]]; then
  #     mkdir -p ".inflated"
  #   elif [[ "${LINE}" =~ 'inflating:' ]]; then
  #     TARGET=".inflated/$(grep -Po "(?<=inflating:\s).*" <<<"${LINE}")"
  #     mkdir -p "$(dirname "${TARGET}")"
  #     echo "${TARGET}"
  #   else
  #     echo "${LINE}" \
  #       | sed 's/\\0/\x0/g' | sed 's/\\\\/\\/g' \
  #         > "${TARGET}"
  #     echo -n "."
  #   fi
  # done < <(echo "${INPUT}")
  # 
  # # Compress the directory
  # pushd ".inflated" > /dev/null
  # zip -rq "contents.zip" .
  # # Print zipped contents to stdout
  # #cat "contents.zip"
  # popd > /dev/null
  # # Remove generated directory
  # #rm -rf ".inflated"

  # # Get line numbers of file names
  # FILE_LIST="$(echo "${INPUT}" | grep -naP "^\s+inflating:\s")"
  # # Get line numbers where files end
  # END_COL="$(echo -e "${FILE_LIST}\n$(( $(wc -l <(echo "${INPUT}") | grep -Po "^\d+") + 1))" | grep -Po "^\d+" | tail +2)"
  # # Combine columns
  # FILE_LIST_END="$(paste <(echo "${FILE_LIST}") <(echo "${END_COL}"))"
  # 

  # Get line numbers of file names
  FILE_LIST="$(echo "${INPUT}" | grep -naP "^\s+inflating:\s")"
  # Get line numbers where files end
  END_COL="$(echo -e "${FILE_LIST}\n$(( $(wc -l <(echo "${INPUT}") | grep -Po "^\d+") + 1))" | grep -Po "^\d+" | tail +2)"
  # Combine columns
  FILE_LIST_END="$(paste <(echo "${FILE_LIST}") <(echo "${END_COL}"))"
  while read -ra LINE; do
    # Make the directory for the file
    mkdir -p ".inflated/$(dirname ${LINE[2]})"
    # Print the contents, starting at $(( "${LINE[0]//:}" + 1)) and ending at $(( "${LINE[3]}" - 1 )), replacing null bytes and backslashes
    echo "${INPUT}" \
      | sed -n "$(( "${LINE[0]//:}" + 1)),$(( "${LINE[3]}" - 1 )) p" \
      | sed 's/\\0/\x0/g' | sed 's/\\\\/\\/g' \
        > ".inflated/${LINE[2]}"
  done < <(echo "${FILE_LIST_END}")
  
  # Compress the directory
  pushd ".inflated" > /dev/null
  zip -rq "contents.zip" .
  # Print zipped contents to stdout
  cat "contents.zip"
  popd > /dev/null
  # Remove generated directory
  rm -rf ".inflated"
else
  # Output file as-is
  echo "${INPUT}"
fi

exit



echo "Filename: ${1}" >> filename.txt

cat


#rm "./${1}"
#zip

# - -

#cat

exit

pushd outagain2.mlapp.inflate; zip -mr ../outfile2.mlapp * ; popd ; rmdir outagain2.mlapp.inflate/
