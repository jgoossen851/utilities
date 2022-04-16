#!/bin/bash
# Adapted from https://askubuntu.com/a/630674/
# with edits from answer's comments,
# leader line from https://stackoverflow.com/a/42762743/,
# and color and formatting added by Jeremy Goossen.
# List of snap packages added by Jeremy Goossen.
#
# Copyright (c) 2021 by Jeremy Goossen

## APT sources ##

echo "APT sources in /etc/apt/sources.list.d/"
cat /etc/apt/sources.list.d/*.list | grep -P --color=auto "http.*?\s"
echo

## GPG Keyrings ##

echo "GPG Keyrings (not Ubuntu) in /usr/share/keyrings/"
ls --color=auto -1 /usr/share/keyrings/ | grep -v "^ubuntu" | grep --color=auto "^.*\.gpg"
echo


## APT-GET PACKAGES
# List of all packages currently installed
current=$(dpkg --list | awk '{print $2}' | cut --fields=1 --delimiter=":" | sort --unique)

# List of all packages that were installed with the system
pre=$(gzip --decompress --stdout /var/log/installer/initial-status.gz | sed --quiet 's/^Package: //p' | cut --fields=1 --delimiter=":" | sort --unique )

# List of packages that don't depend on any other package
manual=$(apt-mark showmanual | cut --fields=1 --delimiter=":" | sort --unique )

# (Current - Pre) ∩ (Manual)
packages=$(comm -12 <(comm -23 <(echo "$current") <(echo "$pre")) <(echo "$manual") )

for pack in $packages; do
    packname=$(echo $pack | cut --fields=1 --delimiter=":")
    desc=$(apt-cache search "^$packname$" | sed --regexp-extended 's/.* - (.*)/\1/')
    date=$(date --reference=/var/lib/dpkg/info/$pack.list)
    
    # Print leader line, package description, and date
    printf '\e[2m%*s\e[0m' "${COLUMNS:-$(tput cols)}" '' | tr ' ' .
    echo -e "\e[G# $desc \e[999C\e[29D $date "
    
    # Print command to install package
    echo -e "sudo apt-get install \e[31m$pack\e[0m"
    echo -e ""
done

## SNAP PACKAGES ##
# Get currently installed snaps not published by canonical
packages=$(snap list | tail --lines=+2 | grep --invert-match canonical | awk '{print $1}' | sort --unique)

for pack in $packages; do
    packname=$(echo $pack | cut --fields=1 --delimiter=":")
    desc=$(snap info $packname | grep "summary:" | sed --regexp-extended 's/summary:\s*(.*)/\1/')
    date=$(snap info --abs-time $packname | grep "refresh-date:" | sed --regexp-extended 's/refresh-date:\s*(.*)/\1/' | date --file -)
    
    # Print leader line, package description, and date
    printf '\e[2m%*s\e[0m' "${COLUMNS:-$(tput cols)}" '' | tr ' ' .
    echo -e "\e[G# $desc \e[999C\e[29D $date "
    
    # Print command to install package
    echo -e "sudo snap install \e[36m$pack\e[0m"
    echo -e ""
done


## PYTHON INSTALLATIONS
echo "Packages installed with pip"
echo -e "\e[41mNot Yet Implemented\e[0m"
echo ""

## LOCALLY INSTALLED PACKAGES

echo "Locally Installed packages in /usr/local/bin"
ls --color=auto -1 /usr/local/bin/
echo -e ""


echo "Locally Installed packages in ~/.local/bin/"
ls --color=auto -1 ~/.local/bin/
echo -e ""
