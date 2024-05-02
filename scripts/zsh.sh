#!/usr/bin/env bash

set -euo pipefail

VER=5.9
TOOL=zsh
URL=https://sourceforge.net/projects/zsh/files/zsh/${VER}/zsh-${VER}.tar.xz/download
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
OUTDIR=${BIN}/${TOOL}-${VER}
TMPDIR=$(mktemp -d)

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

source ${SCRIPT_DIR}/utils.sh
make_install_dir ${OUTDIR}

cd ${TMPDIR}
wget ${URL} -O ${TOOL}-${VER}.tar.xz
tar xf ${TOOL}-${VER}.tar.xz
cd ${TOOL}-${VER}
./configure --prefix=${OUTDIR}
make && make install
cd

rm -rf ${TMPDIR}

>&2 echo Done
exit 0
