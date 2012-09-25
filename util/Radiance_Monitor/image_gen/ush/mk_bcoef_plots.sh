#!/bin/ksh

#------------------------------------------------------------------
#
# mk_bcoef_plots.sh
#
# submit the plot jobs to make the bcoef images.
#
#------------------------------------------------------------------

set -ax
date
export list=$listvar

imgndir="${IMGNDIR}/bcoef"
tankdir="${TANKDIR}/bcoef"

if [[ ! -d ${imgndir} ]]; then
   mkdir -p ${imgndir}
fi

#-------------------------------------------------------------------
#  Locate/update the control files.  If no ctl file is available
#  report a warning to the log file.  Search order is $imgndir,
#  the $TANKDIR/radmon.$PDY, then $tankdir.
#
allmissing=1
PDY=`echo $PDATE|cut -c1-8`
for type in ${SATYPE}; do
   found=0

   if [[ -s ${imgndir}/${type}.ctl.${Z} || -s ${imgndir}/${type}.ctl ]]; then
      allmissing=0
      found=1

   elif [[ -s ${TANKDIR}/radmon.${PDY}/bcoef.${type}.ctl || -s ${TANKDIR}/radmon.${PDY}/bcoef.${type}.ctl.${Z} ]]; then
      $NCP ${TANKDIR}/radmon.${PDY}/bcoef.${type}.ctl.${Z} ${imgndir}/${type}.ctl.${Z}
      if [[ ! -s ${imgndir}/${type}.ctl.${Z} ]]; then
         $NCP ${TANKDIR}/radmon.${PDY}/bcoef.${type}.ctl ${imgndir}/${type}.ctl
      fi
      allmissing=0
      found=1

   elif [[ -s ${tankdir}/${type}.ctl.${Z} || -s ${tankdir}/${type}.ctl  ]]; then
      $NCP ${tankdir}/${type}.ctl* ${imgndir}/.
      allmissing=0
      found=1

   else
      echo WARNING:  unable to locate ${type}.ctl
   fi
done

# TESTING
#export SATYPE="sndrd1_g15"

#-------------------------------------------------------------------
#   Update the time definition (tdef) line in the bcoef control
#   files.
#
#   Note that the logic for the tdef in time series is backwards
#   from angle series.  Time tdefs start at -720 from PDATE.  For
#   angle series the tdef = $PDATE and the script works backwards.
#   Some consistency on this point would be great.

start_date=`$NDATE -720 $PDATE`

for type in ${SATYPE}; do
   if [[ -s ${imgndir}/${type}.ctl.${Z} ]]; then
     ${UNCOMPRESS} ${imgndir}/${type}.ctl.${Z}
   fi
   ${SCRIPTS}/update_ctl_tdef.sh ${imgndir}/${type}.ctl ${start_date}
   ${COMPRESS} ${imgndir}/${type}.ctl
done



#-------------------------------------------------------------------
# submit plot job
#

jobname="plot_${SUFFIX}_bcoef"
logfile="$LOGDIR/plot_bcoef.log"
rm ${logfile}

if [[ $MY_OS = "aix" ]]; then
   $SUB -a $ACCOUNT -e $listvar -j ${jobname} -u $USER -q dev  -g ${USER_CLASS} -t 1:00:00 -o ${logfile} $SCRIPTS/plot_bcoef.sh
else
   $SUB -A $ACCOUNT -l procs=1,walltime=1:30:00 -N ${jobname} -v $listvar -j oe -o ${logfile} $SCRIPTS/plot_bcoef.sh 
fi

exit
