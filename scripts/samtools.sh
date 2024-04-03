#!/usr/bin/env bash

set -euo pipefail

VER=1.19.2
TOOL=samtools
URL=https://github.com/samtools/samtools/releases/download/${VER}/${TOOL}-${VER}.tar.bz2
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
OUTDIR=${BIN}/${TOOL}-${VER}
TMPDIR=$(mktemp -d)

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

if [[ -d ${OUTDIR} ]]; then
   >&2 echo ${OUTDIR} already exists
   exit 1
else
   mkdir -p ${OUTDIR}
fi

cd ${TMPDIR}
wget ${URL}
tar xjf ${TOOL}-${VER}.tar.bz2
cd ${TOOL}-${VER}
./configure --prefix=${OUTDIR}
make && make install
cd

rm -rf ${TMPDIR}

>&2 echo Done
exit 0
