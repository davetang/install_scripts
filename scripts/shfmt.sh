#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(dirname "$(realpath "$0")")
source "${SCRIPT_DIR}"/utils.sh

find_tool go
go install mvdan.cc/sh/v3/cmd/shfmt@latest

>&2 echo "shfmt installed to ${HOME}/go/bin"
${HOME}/go/bin/shfmt --version
>&2 echo Done
exit 0
