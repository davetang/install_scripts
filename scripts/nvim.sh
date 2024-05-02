#!/usr/bin/env bash

set -euo pipefail

TOOL=nvim
VER=0.9.5
TOOL_VER=${TOOL}-${VER}
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
OUTDIR=${BIN}/${TOOL}-${VER}
TMPDIR=$(mktemp -d)

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

source ${SCRIPT_DIR}/utils.sh
make_install_dir ${OUTDIR}

KERNEL=$(get_kernel_name)
if [[ ${KERNEL} == Linux ]]; then
   URL=https://github.com/neovim/neovim/releases/download/v${VER}/nvim-linux64.tar.gz
elif [[ ${KERNEL} == Darwin ]]; then
   URL=https://github.com/neovim/neovim/releases/download/v${VER}/nvim-macos.tar.gz
else
   >&2 echo Unsupported platform: ${KERNEL}
fi

cd ${TMPDIR}
wget ${URL}
tar xzf ${TOOL}-*.tar.gz
rm ${TOOL}-*.tar.gz
cd ${TOOL}-*
mv ./* ${OUTDIR}
cd

rm -rf ${TMPDIR}

>&2 echo Done
exit 0
