#!/usr/bin/env bash

set -euo pipefail

TOOL=ncbi-blast
VER=2.15.0
TOOL_VER=${TOOL}-${VER}
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
OUTDIR=${BIN}/${TOOL}-${VER}
TMPDIR=$(mktemp -d)

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

source ${SCRIPT_DIR}/utils.sh
make_install_dir ${OUTDIR}

install(){
   if [[ $# != 1 ]]; then
      >&2 echo Please provide URL
      exit 1
   fi
   URL=$1
   cd ${TMPDIR}

   wget --quiet ${URL} \
      && tar xzf *.tar.gz \
      && rm *.tar.gz \
      && mv * ${OUTDIR}

   cd
   rm -rf ${TMPDIR}
}

ARCH=$(arch)

if [[ ${ARCH} == x86_64 ]]; then
   install ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/${VER}/ncbi-blast-${VER}+-x64-linux.tar.gz
else
   >&2 echo Unknown arch: ${ARCH}
   exit 1
fi

>&2 echo Done
exit 0
