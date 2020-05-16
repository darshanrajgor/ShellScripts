#!/bin/sh

search () {
   for dir in `echo *`
   do
      if [ -d "$dir" ] ; then   
         zz=0   
         while [ $zz != $deep ] 
         do
            echo -n "|   "   
            zz=`expr $zz + 1` 
         done
         if [ -L "$dir" ] ; then  
            echo "+---$dir" `ls -l $dir | sed 's/^.*'$dir' //'`
         else
            echo "+---$dir"     
            if cd "$dir" ; then 
               deep=`expr $deep + 1`  
               search    
               numdirs=`expr $numdirs + 1`  
            fi
         fi
      fi
   done
   cd ..  
   if [ "$deep" ] ; then  
      swfi=1             
   fi
   deep=`expr $deep - 1`  
}

if [ $# = 0 ] ; then
   cd `pwd`   
else
   cd $1    
fi
echo "Initial directory = `pwd`"
swfi=0     
deep=0    
numdirs=0
zz=0

while [ "$swfi" != 1 ]  
do
   search 
done
echo "Total directories = $numdirs"

exit 0
# ==> Challenge: try to figure out exactly how this script works.
