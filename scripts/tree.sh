#!/usr/bin/env bash

set -euo pipefail

VER=2.1.1
TOOL=tree
URL=https://fossies.org/linux/misc/tree-${VER}.tgz
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
tar -xzf tree-${VER}.tgz
cd tree-${VER}/
make
mv tree ${OUTDIR}
cd

rm -rf ${TMPDIR}

>&2 echo Done
exit 0
