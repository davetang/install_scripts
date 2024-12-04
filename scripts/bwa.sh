#!/usr/bin/env bash

set -euo pipefail

VER=0.7.18
TOOL=bwa
URL=https://github.com/lh3/bwa/archive/refs/tags/v${VER}.tar.gz
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
OUTDIR=${BIN}/${TOOL}-${VER}
TMPDIR=$(mktemp -d)

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

source ${SCRIPT_DIR}/utils.sh
make_install_dir ${OUTDIR}

cd ${TMPDIR}
wget ${URL} -O ${TOOL}-${VER}.tar.gz
tar xzf ${TOOL}-${VER}.tar.gz
cd ${TOOL}-${VER}
make && mv ${TOOL} ${OUTDIR}
cd

rm -rf ${TMPDIR}

>&2 echo Done
exit 0
