#!/usr/bin/env bash

set -euo pipefail

VER=2.55.0
TOOL=gh
URL=https://github.com/cli/cli/releases/download/v${VER}/gh_${VER}_linux_amd64.tar.gz
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
OUTDIR=${BIN}/${TOOL}-${VER}
TMPDIR=$(mktemp -d)

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

source ${SCRIPT_DIR}/utils.sh
make_install_dir ${OUTDIR}

cd ${TMPDIR}

wget ${URL}
tar -xzf $(basename ${URL})
mv $(basename ${URL} .tar.gz) ${OUTDIR}
cd

rm -rf ${TMPDIR}

>&2 echo Done
exit 0
