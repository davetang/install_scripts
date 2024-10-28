#!/usr/bin/env bash

set -euo pipefail

VER=1.5.0
TOOL=make2graph
URL=https://github.com/lindenb/makefile2graph.git
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
OUTDIR=${BIN}/${TOOL}-${VER}
TMPDIR=$(mktemp -d)

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

source ${SCRIPT_DIR}/utils.sh
make_install_dir ${OUTDIR}

cd ${TMPDIR}
git clone https://github.com/lindenb/makefile2graph.git
cd makefile2graph
make
./make2graph --version
mv make2graph ${OUTDIR}
cd

rm -rf ${TMPDIR}

>&2 echo Done
exit 0
