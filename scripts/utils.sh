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

get_kernel_name(){
   # -s, --kernel-name print the kernel name
   uname -s
}

get_arch(){
   # -m Write the type of the current hardware platform to standard output
   uname -m
}
