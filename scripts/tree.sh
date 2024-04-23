#!/usr/bin/env bash

set -euo pipefail

VER=2.1.1
TOOL=tree
URL=https://fossies.org/linux/misc/tree-${VER}.tgz
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
OUTDIR=${BIN}/${TOOL}-${VER}
TMPDIR=$(mktemp -d)

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

source ${SCRIPT_DIR}/utils.sh
make_install_dir ${OUTDIR}

cd ${TMPDIR}

wget ${URL}
tar -xzf tree-${VER}.tgz
cd tree-${VER}/
make
mv tree ${OUTDIR}
cd

rm -rf ${TMPDIR}

>&2 echo Done
exit 0
