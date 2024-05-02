#!/usr/bin/env bash

set -euo pipefail

PLUG="${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim

if [[ ! -e ${PLUG} ]]; then
   sh -c "curl -fLo ${PLUG} --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
else
   >&2 echo ${PLUG} already exists
fi

>&2 echo Done
exit 0
