#!/usr/bin/env bash

set -euo pipefail

TOOL=datasets
SCRIPT_DIR=$(dirname "$(realpath "$0")")
source "${SCRIPT_DIR}"/config.sh
source "${SCRIPT_DIR}"/utils.sh
OUTDIR=${BIN}/${TOOL}_dir
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
      && chmod 755 "$(basename "${URL}")" \
      && mv -f $(basename "${URL}") "${OUTDIR}"

   cd
   rm -rf "${TMPDIR}"
}

if [[ ${OS} == Darwin ]]; then
   make_install_dir "${OUTDIR}"
   install https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v2/mac/datasets
elif [[ ${OS} =~ Linux ]]; then
   if [[ ${ARCH} == x86_64 ]]; then
      make_install_dir "${OUTDIR}"
      install https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v2/linux-amd64/datasets
   elif [[ ${ARCH} =~ arm ]]; then
      make_install_dir "${OUTDIR}"
      install https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v2/linux-arm64/datasets
   else
      >&2 echo Unsupported arch: "${ARCH}"
      exit 1
   fi
fi

>&2 echo Done
exit 0
