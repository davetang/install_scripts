BIN=${HOME}/bin
if [[ ! -d ${BIN} ]]; then
   >&2 echo Creating ${BIN}
   mkdir ${BIN}
fi
