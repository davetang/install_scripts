#!/usr/bin/env bash
#
# Visit https://jdk.java.net/archive/ to find different versions
#

set -euo pipefail

TOOL=jdk
VER=21.0.2
TOOL_VER=${TOOL}-${VER}
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
OUTDIR=${BIN}/${TOOL}-${VER}
TMPDIR=$(mktemp -d)

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

source ${SCRIPT_DIR}/utils.sh
make_install_dir ${OUTDIR}

install(){
   if [[ $# != 1 ]]; then
      >&2 echo Please provide URL
      exit 1
   fi
   URL=$1
   cd ${TMPDIR}

   wget --quiet ${URL} \
      && tar xzf *.tar.gz \
      && rm *.tar.gz \
      && mv ${TOOL_VER}/* ${OUTDIR}

   cd
   rm -rf ${TMPDIR}
}

ARCH=$(arch)

if [[ ${ARCH} == x86_64 ]]; then
   install https://download.java.net/java/GA/jdk21.0.2/f2283984656d49d69e91c558476027ac/13/GPL/openjdk-21.0.2_linux-x64_bin.tar.gz
else
   >&2 echo Unknown arch: ${ARCH}
   exit 1
fi

>&2 echo Done
exit 0
