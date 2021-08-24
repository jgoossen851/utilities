#!/bin/bash

git config --global alias.lg '!f() { : git log ; \
		LOG_LINE_LENGTH=$((`tput cols`-20)); \
		FORMAT_STRING='"'"'%C(yellow)%h%Creset %C(bold blue)<%an>%Creset %C(auto)%d%Creset %<|('"'"'$LOG_LINE_LENGTH'"'"',trunc) %s %Cgreen(%cr)'"'"'; \
		git log --graph --abbrev-commit --date=relative --all --max-count=35 --pretty=format:"$FORMAT_STRING" "$@"; \
	}; f'
