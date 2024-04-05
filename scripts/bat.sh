#!/usr/bin/env bash

set -euo pipefail

TOOL=bat
VER=0.24.0
TOOL_VER=${TOOL}-${VER}
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
OUTDIR=${BIN}/${TOOL}-${VER}
TMPDIR=$(mktemp -d)

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

if [[ -d ${OUTDIR} ]]; then
   >&2 echo ${OUTDIR} already exists
   exit 1
else
   mkdir ${OUTDIR}
fi

install_bat(){
   if [[ $# != 1 ]]; then
      >&2 echo Please provide URL
      exit 1
   fi
   URL=$1
   cd ${TMPDIR}

   wget --quiet ${URL} \
      && tar xzf bat-*.tar.gz \
      && mv -f bat-*/bat ${OUTDIR}

   cd
   rm -rf ${TMPDIR}
}

ARCH=$(arch)

if [[ ${ARCH} == x86_64 ]]; then
   install_bat https://github.com/sharkdp/bat/releases/download/v${VER}/bat-v${VER}-x86_64-unknown-linux-musl.tar.gz
elif [[ ${ARCH} =~ arm ]]; then
   install_bat https://github.com/sharkdp/bat/releases/download/v${VER}/bat-v${VER}-arm-unknown-linux-musleabihf.tar.gz
elif [[ ${ARCH} =~ aarch64 ]]; then
   install_bat https://github.com/sharkdp/bat/releases/download/v${VER}/bat-v${VER}-aarch64-unknown-linux-gnu.tar.gz
else
   >&2 echo Unknown arch: ${ARCH}
   exit 1
fi

>&2 echo Done
exit 0
