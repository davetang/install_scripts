#!/usr/bin/env bash

set -euo pipefail

if [[ -d ${HOME}/miniforge3 ]]; then
   >&2 echo ${HOME}/miniforge3 already exists
   exit 1
fi

ARCH=$(arch)
OS=$(uname -o)

if [[ ${ARCH} == x86_64 && ${OS} =~ Linux ]]; then
   URL=https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh
elif [[ ${ARCH} == aarch64 && {OS} =~ Linux ]]; then
   URL=https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh
elif [[ ${ARCH} =~ arm && {OS} =~ Darwin ]]; then
   URL=https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh
else
   >&2 echo Unexpected architecture ${ARCH} and OS combination ${OS}
   exit 1
fi
>&2 echo ${ARCH} and ${OS} detected

SCRIPT=$(basename ${URL})

if [[ ! -e ${SCRIPT} ]]; then
   wget ${URL}
fi

bash ${SCRIPT}

if [[ $? -eq 0 ]]; then
   rm ${SCRIPT}
fi

>&2 echo Done
exit 0
