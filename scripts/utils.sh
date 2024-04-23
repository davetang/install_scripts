make_install_dir(){
   if [[ $# < 1 ]]; then
      >&2 echo Please provide DIR path
      exit 1
   fi
   OUTDIR=$1
   if [[ -d ${OUTDIR} ]]; then
      >&2 echo ${OUTDIR} already exists
      exit 1
   else
      mkdir -p ${OUTDIR}
   fi
}
