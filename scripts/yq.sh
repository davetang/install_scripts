#!/usr/bin/env bash

set -euo pipefail

TOOL=yq
VER=4.44.3
TOOL_VER=${TOOL}-${VER}
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
source ${SCRIPT_DIR}/utils.sh
OUTDIR=${BIN}/${TOOL}-${VER}
TMPDIR=$(mktemp -d)
ARCH=$(get_arch)
OS=$(get_kernel_name)

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

install_yq(){
   if [[ $# != 1 ]]; then
      >&2 echo Please provide URL
      exit 1
   fi
   URL=$1
   cd ${TMPDIR}

   wget --quiet ${URL} \
      && chmod 755 yq_* \
      && mv yq_* ${OUTDIR}

   cd
   rm -rf ${TMPDIR}
}

if [[ ${OS} == Darwin ]]; then
   if [[ ${ARCH} == arm64 ]]; then
      make_install_dir ${OUTDIR}
      install_yq https://github.com/mikefarah/yq/releases/download/v${VER}/yq_darwin_arm64
   else
      >&2 echo Unsupported arch: ${ARCH}
      exit 1
   fi
elif [[ ${OS} =~ Linux ]]; then
   if [[ ${ARCH} == x86_64 ]]; then
      echo Please implement
   elif [[ ${ARCH} =~ arm ]]; then
      echo Please implement
   elif [[ ${ARCH} =~ aarch64 ]]; then
      echo Please implement
   else
      >&2 echo Unsupported arch: ${ARCH}
      exit 1
   fi
fi

>&2 echo Done
exit 0
