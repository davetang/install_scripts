#!/usr/bin/env bash

set -euo pipefail

plug_file="${HOME}/.vim/autoload/plug.vim"

if [[ ! -e ${plug_file} ]]; then
   curl -fLo ${plug_file} --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
   >&2 echo ${plug_file} already exists
fi

>&2 echo Done
exit 0
