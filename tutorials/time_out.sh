#!/bin/bash

TIMELIMIT=3  

PrintAnswer()
{
  if [ "$answer" = TIMEOUT ]
  then
    echo $answer
  else       
    echo "Your favorite veggie is $answer"
    kill $!
  fi

}  



TimerOn()
{
  sleep $TIMELIMIT && kill -s 14 $$ &
  # Waits 3 seconds, then sends sigalarm to script.
}  

Int14Vector()
{
  answer="TIMEOUT"
  PrintAnswer
  exit 14
}  

trap Int14Vector 14   .

echo "What is your favorite vegetable "
TimerOn
read answer
PrintAnswer

exit 0
