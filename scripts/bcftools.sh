#!/usr/bin/env bash

set -euo pipefail

VER=1.19
TOOL=bcftools
URL=https://github.com/samtools/bcftools/releases/download/${VER}/${TOOL}-${VER}.tar.bz2
OUTDIR=${HOME}/bin/${TOOL}-${VER}
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
