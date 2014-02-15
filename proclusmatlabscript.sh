# run job using bash from directory it was submitted from

#! /bin/bash
#$ -cwd

#$ -j y
#$ -R y
#$ -w e

# email address to send notices to
#$ -M pusiol@stanford.edu
#$ -m beas

# set a name to make it easy to pick out of qstat output$
#$ -N Entretainment

# if you need more than 1 slot on the same machine
##$ -pe fah 12

#memory request (if you want something other than default 4GB hard limit)
  ##$ -l h_vmem=XG



##echo "loading...."
##module load python

echo "loading matlab" 
module load MATLAB-R2012b

##echo ""
##echo "final list"
##module list

##matlab -r "directoryin='/mnt/glusterfs/pusiol/Data/FaceInput/';directoryout='/mnt/glusterfs/pusiol/Data/FaceInput-Results/';"</afs/.ir/users/p/u/pusiol/prototypes-vision-ai/trunk/face-release1.0-basic/demo.m

#just print the name of this machine
nohup matlab -r "directoryin='/hsgs/projects/mcfrank/Guido/Data/Face/EVID/';directoryout='/hsgs/projects/mcfrank/Guido/Data/Face/EVID-Results/'"</home/pusiol/prototypes-vision-ai/trunk/face-release1.0-basic/proclusdemo.m
