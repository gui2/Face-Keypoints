#!/bin/bash
##-l h_rt=72:00:00
for i in {1..80}
do
   qsub -pe shm 1 proclusmatlabscripWILDFACES.sh
   sleep 10
done
