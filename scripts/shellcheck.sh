#!/usr/bin/env bash

set -euo pipefail

TOOL=shellcheck
VER=0.10.0
TOOL_VER=${TOOL}-${VER}
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
source ${SCRIPT_DIR}/utils.sh
OUTDIR=${BIN}/${TOOL}-${VER}
TMPDIR=$(mktemp -d)
ARCH=$(get_arch)
OS=$(get_kernel_name)

>&2 echo ${OS} and ${ARCH} detected

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

install(){
   if [[ $# != 1 ]]; then
      >&2 echo Please provide URL
      exit 1
   fi
   URL=$1
   cd ${TMPDIR}

   wget --quiet ${URL} \
      && tar xJf $(basename ${URL}) \
      && mv -f shellcheck-v${VER}/${TOOL} ${OUTDIR}

   cd
   rm -rf ${TMPDIR}
}

if [[ ${OS} == Darwin ]]; then
   if [[ ${ARCH} == x86_64 ]]; then
      make_install_dir ${OUTDIR}
      install https://github.com/koalaman/shellcheck/releases/download/v${VER}/shellcheck-v${VER}.darwin.x86_64.tar.xz
   elif [[ ${ARCH} == arm64 ]]; then
      make_install_dir ${OUTDIR}
      install https://github.com/koalaman/shellcheck/releases/download/v${VER}/shellcheck-v${VER}.darwin.aarch64.tar.xz
   else
      >&2 echo Unsupported arch: ${ARCH}
      exit 1
   fi
elif [[ ${OS} =~ Linux ]]; then
   if [[ ${ARCH} == x86_64 ]]; then
      make_install_dir ${OUTDIR}
      install https://github.com/koalaman/shellcheck/releases/download/v${VER}/shellcheck-v${VER}.linux.x86_64.tar.xz
   elif [[ ${ARCH} =~ arm ]]; then
      make_install_dir ${OUTDIR}
      install https://github.com/koalaman/shellcheck/releases/download/v${VER}/shellcheck-v${VER}.linux.armv6hf.tar.xz
   elif [[ ${ARCH} =~ aarch64 ]]; then
      make_install_dir ${OUTDIR}
      install https://github.com/koalaman/shellcheck/releases/download/v${VER}/shellcheck-v${VER}.linux.aarch64.tar.xz
   else
      >&2 echo Unsupported arch: ${ARCH}
      exit 1
   fi
fi

>&2 echo Done
exit 0
