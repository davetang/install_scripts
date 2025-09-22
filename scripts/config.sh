SCRIPT_DIR=$(dirname $(realpath $0))
source ${SCRIPT_DIR}/utils.sh
BIN=${HOME}/bin
LIB=${HOME}/lib
ensure_dir ${BIN}
ensure_dir ${LIB}
