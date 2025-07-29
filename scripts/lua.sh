#!/usr/bin/env bash

set -euo pipefail

VER=5.4.8
TOOL=lua
URL=https://www.lua.org/ftp/lua-${VER}.tar.gz
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
OUTDIR=${BIN}/${TOOL}-${VER}
TMPDIR=$(mktemp -d)

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

source ${SCRIPT_DIR}/utils.sh
make_install_dir ${OUTDIR}

cd ${TMPDIR}
wget ${URL}

# get checksum from https://www.lua.org/ftp/
echo "4f18ddae154e793e46eeab727c59ef1c0c0c2b744e7b94219710d76f530629ae  ${TOOL}-${VER}.tar.gz" | sha256sum -c -
tar xzf ${TOOL}-${VER}.tar.gz
cd ${TOOL}-${VER}
make all test
mv src/lua src/luac ${OUTDIR}
cd

rm -rf ${TMPDIR}

>&2 echo Done
exit 0
