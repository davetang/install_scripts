#!/usr/bin/env bash

set -euo pipefail

TOOL=ncdu
VER=2.9.1
SCRIPT_DIR=$(dirname "$(realpath "$0")")
source "${SCRIPT_DIR}"/config.sh
source "${SCRIPT_DIR}"/utils.sh
OUTDIR=${BIN}/${TOOL}-${VER}
TMPDIR=$(mktemp -d)
ARCH=$(get_arch)
OS=$(get_kernel_name)

>&2 echo "${OS}" and "${ARCH}" detected

trap 'rm -rf ${TMPDIR}' SIGINT SIGTERM

install(){
   if [[ $# != 1 ]]; then
      >&2 echo Please provide URL
      exit 1
   fi
   URL=$1
   cd "${TMPDIR}"

   wget --quiet "${URL}" \
      && tar xzf "$(basename "${URL}")" \
      && mv -f ${TOOL} "${OUTDIR}"

   cd
   rm -rf "${TMPDIR}"
}

if [[ ${OS} == Linux ]]; then
   if [[ ${ARCH} == x86_64 ]]; then
      make_install_dir "${OUTDIR}"
      install https://dev.yorhel.nl/download/ncdu-${VER}-linux-x86_64.tar.gz
   elif [[ ${ARCH} =~ aarch64 ]]; then
      make_install_dir "${OUTDIR}"
      install https://dev.yorhel.nl/download/ncdu-${VER}-linux-aarch64.tar.gz
   else
      >&2 echo Unsupported arch: "${ARCH}"
      exit 1
   fi
fi

>&2 echo Done
exit 0
