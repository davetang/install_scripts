#!/usr/bin/env bash

set -euo pipefail

VER=1.9.1
TOOL=lsix
URL=https://raw.githubusercontent.com/hackerb9/lsix/refs/heads/master/lsix
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
source "${SCRIPT_DIR}"/config.sh
OUTDIR=${BIN}/${TOOL}-${VER}
TMPDIR=$(mktemp -d)

trap 'rm -rf "$TMPDIR"' SIGINT SIGTERM

source "${SCRIPT_DIR}"/utils.sh
make_install_dir "${OUTDIR}"

cd "${TMPDIR}"
wget ${URL} -O ${TOOL}
chmod 755 ${TOOL}
mv ${TOOL} ${OUTDIR}
cd

rm -rf "${TMPDIR}"

>&2 echo Done
exit 0
