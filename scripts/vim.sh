#!/usr/bin/env bash

set -euo pipefail

TOOL=vim
VER=9.1.0386
TOOL_VER=${TOOL}-${VER}
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
OUTDIR=${BIN}/${TOOL}-${VER}
TMPDIR=$(mktemp -d)

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

source ${SCRIPT_DIR}/utils.sh
make_install_dir ${OUTDIR}

cd ${TMPDIR}
wget https://github.com/vim/vim/archive/refs/tags/v${VER}.tar.gz
tar xzf v${VER}.tar.gz
cd ${TOOL_VER}
./configure --prefix=${OUTDIR}
make && make install
cd

rm -rf ${TMPDIR}

>&2 echo Done
exit 0
