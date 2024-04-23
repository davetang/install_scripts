#!/usr/bin/env bash

set -euo pipefail

TOOL=viddy
VER=0.4.0
TOOL_VER=${TOOL}-${VER}
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
OUTDIR=${BIN}/${TOOL}-${VER}
TMPDIR=$(mktemp -d)

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

source ${SCRIPT_DIR}/utils.sh
make_install_dir ${OUTDIR}

install_tool(){
   if [[ $# != 1 ]]; then
      >&2 echo Please provide URL
      exit 1
   fi
   URL=$1
   cd ${TMPDIR}

   wget --quiet -O tool.tar.gz ${URL} \
      && tar xzf tool.tar.gz \
      && mv ${TOOL} ${OUTDIR}

   cd
   rm -rf ${TMPDIR}
}

ARCH=$(arch)

if [[ ${ARCH} == x86_64 ]]; then
   install_tool https://github.com/sachaos/viddy/releases/download/v${VER}/viddy_Linux_x86_64.tar.gz
else
   >&2 echo Unknown arch: ${ARCH}
   exit 1
fi

>&2 echo Done
exit 0
