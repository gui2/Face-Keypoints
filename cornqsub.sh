#!/bin/bash
##-l h_rt=72:00:00
for i in {1..50}
do
   qsub  cornmatlabScript.sh
done
