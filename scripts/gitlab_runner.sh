#!/usr/bin/env bash

set -euo pipefail

# https://docs.gitlab.com/runner/install/linux-manually/#using-binary-file
TOOL=gitlab-runner
SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/config.sh
OUTDIR=${BIN}/gitlab
TMPDIR=$(mktemp -d)

trap "rm -rf ${TMPDIR}" SIGINT SIGTERM

source ${SCRIPT_DIR}/utils.sh
make_install_dir ${OUTDIR}

KERNEL=$(get_kernel_name)
ARCH=$(get_arch)
if [[ ${KERNEL} == Linux ]]; then
   if [[ ${ARCH} == x86_64 ]]; then
      >&2 echo ${KERNEL} ${ARCH} detected
      URL=https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/latest/binaries/gitlab-runner-linux-amd64
   elif [[ ${ARCH} == aarch64 ]]; then
      >&2 echo ${KERNEL} ${ARCH} detected
      URL=https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/latest/binaries/gitlab-runner-linux-arm64
   else
      >&2 echo Unsupported architecture: ${ARCH}
   fi
else
   >&2 echo Unsupported platform: ${KERNEL}
fi

cd ${TMPDIR}
>&2 echo Downloading from ${URL}
wget --quiet ${URL} -O ${TOOL}
chmod 755 ${TOOL}
./${TOOL} --version
mv ${TOOL} ${OUTDIR}
cd

rm -rf ${TMPDIR}

>&2 echo Done
exit 0
