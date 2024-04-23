#!/usr/bin/env bash

set -euo pipefail

TOOL=mummer
VER=4.0.0rc1
TOOL_VER=${TOOL}-${VER}
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
OUTDIR=${BIN}/${TOOL}-${VER}
URL=https://github.com/mummer4/mummer/releases/download/v${VER}/${TOOL_VER}.tar.gz
TMPDIR=$(mktemp -d)

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

source ${SCRIPT_DIR}/utils.sh
make_install_dir ${OUTDIR}

cd ${TMPDIR}
wget ${URL} -O ${TOOL_VER}.tar.gz
tar -xzf ${TOOL_VER}.tar.gz
cd ${TOOL_VER}
./configure --prefix=${OUTDIR}
make && make install
cd
rm -rf ${TMPDIR}

>&2 echo Done
exit 0
