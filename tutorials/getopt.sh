#! /bin/bash
set -x
USAGE="Usage: `basename $0` [-v] [-f] [filename] [-o] [filename]"
VERBOSE=false

while getopts f:o:v OPTION ; do
  case "$OPTION" in
	f) INFILE="$OPTARG";;
	o) OUTFILE="$OPTARG";;
	v) VERBOSE=true;;
       \?) echo "$USAGE" ; exit 1 ;;
  esac
done

shift `echo "$OPTIND - 1 " | bc`

: ${INFILE:=${1:?"Input file not specified"}} ${OUTFILE:=${INFILE}.uu}
if [ -f "$INFILE" ] ; then
 if [ "$VERBOSE" = "true" ] ; then
   echo "Encoding ... "
 fi
 
 cat $INFILE > $OUTFILE 
 RET=$?

if [ "$VERBOSE" = "true" ] ; then
 MSG="Faild"
 if [ $RET -eq 0 ] ; then 
  MSG="Done." 
 fi
 echo $MSG
fi
fi
