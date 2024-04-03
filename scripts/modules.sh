#!/usr/bin/env bash
#
# Needed to install the following for Debian 12
# sudo apt update
# sudo apt install -y tcl tcl-dev tk-dev
#

set -euo pipefail

VER=5.4.0
TOOL=modules
URL=https://github.com/cea-hpc/modules/releases/download/v${VER}/${TOOL}-${VER}.tar.gz
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
OUTDIR=${BIN}/${TOOL}-${VER}

read -p "This script will try to install ${TOOL} version ${VER} in ${OUTDIR}; do you want to continue? y/[n]" continue

if [[ ! ${continue} == "y" ]]; then
   >&2 echo Exiting...
   exit 1
fi

if [[ ! -e ${HOME}/.bashrc ]]; then
   >&2 echo ${HOME}/.bashrc not found
   exit 1
fi

TMPDIR=$(mktemp -d)
trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

if [[ -d ${OUTDIR} ]]; then
   >&2 echo ${OUTDIR} already exists
   exit 1
else
   mkdir -p ${OUTDIR}
fi

cd ${TMPDIR}
wget ${URL}
tar -xzf ${TOOL}-${VER}.tar.gz
cd ${TOOL}-${VER}
./configure --prefix=${OUTDIR}
make && make install
cd
rm -rf ${TMPDIR}

echo source ${OUTDIR}/init/bash >> ~/.bashrc

>&2 echo Done
exit 0
