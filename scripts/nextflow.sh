#!/usr/bin/env bash

set -euo pipefail

TOOL=nextflow
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
OUTDIR=${BIN}
TMPDIR=$(mktemp -d)

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

cd ${TMPDIR}
curl -s https://get.nextflow.io | bash
mv ./${TOOL} ${OUTDIR}
rm -rf ${TMPDIR}

>&2 echo Done
exit 0
