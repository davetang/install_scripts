#!/usr/bin/env bash

set -euo pipefail

TOOL=nextflow
VER=25.04.3
URL=https://github.com/nextflow-io/nextflow/releases/download/v${VER}/nextflow-${VER}-dist
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
OUTDIR=${BIN}/${TOOL}-${VER}
TMPDIR=$(mktemp -d)

make_install_dir ${OUTDIR}
find_tool java

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

cd ${TMPDIR}
>&2 echo "Downloading from ${URL}"
wget --quiet ${URL}
chmod 755 ./nextflow-${VER}-dist
./nextflow-${VER}-dist -version
mv ./nextflow-${VER}-dist ${OUTDIR}
cd
rm -rf ${TMPDIR}

>&2 echo Done
exit 0
