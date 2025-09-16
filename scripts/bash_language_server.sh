#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(dirname "$(realpath "$0")")
source "${SCRIPT_DIR}"/utils.sh
source ${SCRIPT_DIR}/config.sh

find_tool npm
mkdir -p "${LIB}/node_modules"
npm install --global --prefix="${LIB}" bash-language-server

>&2 echo "bash-language-server installed to ${LIB}/bin/bash-language-server"
${LIB}/bin/bash-language-server --version
>&2 echo Done
exit 0
