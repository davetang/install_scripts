#!/usr/bin/env bash

set -euo pipefail

VER=2.8
TOOL=pigz
URL=https://zlib.net/${TOOL}/${TOOL}-${VER}.tar.gz
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
OUTDIR=${BIN}/${TOOL}-${VER}
TMPDIR=$(mktemp -d)

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

source ${SCRIPT_DIR}/utils.sh
make_install_dir ${OUTDIR}

cd ${TMPDIR}
wget ${URL}
tar -xzf ${TOOL}-${VER}.tar.gz
cd ${TOOL}-${VER}
make
mv ${TOOL} un${TOOL} README ${OUTDIR}
cd
rm -rf ${TMPDIR}

>&2 echo Done
exit 0
