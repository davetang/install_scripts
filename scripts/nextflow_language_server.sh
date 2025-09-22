#!/usr/bin/env bash

set -euo pipefail

TOOL=nfls
VER=25.04.3
URL=https://github.com/nextflow-io/language-server/releases/download/v${VER}/language-server-all.jar
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
OUTDIR=${HOME}/opt/${TOOL}/${VER}
TMPDIR=$(mktemp -d)

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

find_tool java

source ${SCRIPT_DIR}/utils.sh
make_install_dir ${OUTDIR}

cd ${TMPDIR}
>&2 echo Downloading from ${URL}
wget --quiet ${URL}
mv ./language-server-all.jar ${OUTDIR}
cd

rm -rf ${TMPDIR}

>&2 echo Done
exit 0
