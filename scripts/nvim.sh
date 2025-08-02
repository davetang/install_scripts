#!/usr/bin/env bash

set -euo pipefail

TOOL=nvim
VER=0.11.0
TOOL_VER=${TOOL}-${VER}
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
OUTDIR=${BIN}/${TOOL}-${VER}
TMPDIR=$(mktemp -d)

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

source ${SCRIPT_DIR}/utils.sh
make_install_dir ${OUTDIR}

KERNEL=$(get_kernel_name)
ARCH=$(get_arch)
if [[ ${KERNEL} == Linux ]]; then
   if [[ ${ARCH} == x86_64 ]]; then
      >&2 echo ${KERNEL} ${ARCH} detected
      URL=https://github.com/neovim/neovim/releases/download/v${VER}/nvim-linux-x86_64.tar.gz
   elif [[ ${ARCH} == aarch64 ]]; then
      >&2 echo ${KERNEL} ${ARCH} detected
      URL=https://github.com/neovim/neovim/releases/download/v${VER}/nvim-linux-arm64.tar.gz
   else
      >&2 echo Unsupported architecture: ${ARCH}
   fi
elif [[ ${KERNEL} == Darwin ]]; then
   if [[ ${ARCH} == x86_64 ]]; then
      >&2 echo ${KERNEL} ${ARCH} detected
      URL=https://github.com/neovim/neovim/releases/download/v${VER}/nvim-macos-x86_64.tar.gz
   elif [[ ${ARCH} == arm64 ]]; then
      >&2 echo ${KERNEL} ${ARCH} detected
      URL=https://github.com/neovim/neovim/releases/download/v${VER}/nvim-macos-arm64.tar.gz
   else
      >&2 echo Unsupported architecture: ${ARCH}
   fi
else
   >&2 echo Unsupported platform: ${KERNEL}
fi

cd ${TMPDIR}
>&2 echo Downloading from ${URL}
wget --quiet ${URL}
tar xzf ${TOOL}-*.tar.gz
rm ${TOOL}-*.tar.gz
cd ${TOOL}-*
mv ./* ${OUTDIR}
cd

rm -rf ${TMPDIR}

>&2 echo Done
exit 0
