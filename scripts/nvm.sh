#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(dirname "$(realpath "$0")")
source "${SCRIPT_DIR}"/utils.sh
VER=0.40.3

find_tool wget
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v${VER}/install.sh | bash

>&2 echo Done
exit 0
