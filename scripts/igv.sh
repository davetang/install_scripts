#!/usr/bin/env bash

set -euo pipefail

TOOL=igv
MAJOR=2
MINOR=19
PATCH=4
VER=${MAJOR}.${MINOR}.${PATCH}
URL=https://data.broadinstitute.org/igv/projects/downloads/${MAJOR}.${MINOR}/IGV_Linux_${VER}_WithJava.zip
ZIP=$(basename ${URL})
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
OUTDIR=${BIN}/${TOOL}-${VER}
TMPDIR=$(mktemp -d)

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

cd ${TMPDIR}
wget -c ${URL}
unzip ${ZIP}
rm ${ZIP}
mv ./* ${OUTDIR}
rm -rf ${TMPDIR}

>&2 echo Done
exit 0
