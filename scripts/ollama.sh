#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(dirname "$(realpath "$0")")
source "${SCRIPT_DIR}"/utils.sh

find_tool curl
curl -fsSL https://ollama.com/install.sh | sh

>&2 echo Done
exit 0
