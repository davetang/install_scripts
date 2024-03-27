#!/usr/bin/env bash

set -euo pipefail

TOOL=aws-cli
OUTDIR=${HOME}/bin/${TOOL}
TMPDIR=$(mktemp -d)

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

cd ${TMPDIR}

CPU=$(arch)
if [[ ${CPU} == x86_64 ]]; then
   curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
elif [[ ${CPU} =~ arm ]]; then
   curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
else
   >&2 echo Unsupported architecture
fi

unzip awscliv2.zip
if [[ -e ${OUTDIR} ]]; then
   >&2 echo ${OUTDIR} already exists; re-installing and/or updating
   ./aws/install --bin-dir ${OUTDIR} --install-dir ${OUTDIR} --update
else
   ./aws/install --bin-dir ${OUTDIR} --install-dir ${OUTDIR}
fi
cd

rm -rf ${TMPDIR}

>&2 echo Done
exit 0
