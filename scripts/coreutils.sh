#!/usr/bin/env bash

set -euo pipefail

VER=9.9
TOOL=coreutils
URL=https://ftp.gnu.org/gnu/coreutils/coreutils-${VER}.tar.xz
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
source "${SCRIPT_DIR}"/config.sh
OUTDIR=${BIN}/${TOOL}-${VER}
TMPDIR=$(mktemp -d)

trap 'rm -rf "$TMPDIR"' SIGINT SIGTERM

source "${SCRIPT_DIR}"/utils.sh
find_tool xz
make_install_dir "${OUTDIR}"

cd "${TMPDIR}"
wget ${URL} -O ${TOOL}-${VER}.tar.xz
tar xJf ${TOOL}-${VER}.tar.xz
cd ${TOOL}-${VER}
./configure --prefix="${OUTDIR}"
make && make install
cd

rm -rf "${TMPDIR}"

>&2 echo Done
exit 0
