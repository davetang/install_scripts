#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(dirname "$(realpath "$0")")
source "${SCRIPT_DIR}"/utils.sh
source "${SCRIPT_DIR}"/config.sh

MY_TOOL=bash-language-server

find_tool npm
mkdir -p "${LIB}/node_modules"
npm install --global --prefix="${LIB}" ${MY_TOOL}

>&2 echo "${MY_TOOL} installed to ${LIB}/bin/${MY_TOOL}"
"${LIB}"/bin/${MY_TOOL} --version
>&2 echo Done
exit 0
