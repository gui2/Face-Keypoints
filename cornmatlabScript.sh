# run job using bash from directory it was submitted from

#! /bin/bash
#$ -cwd

#$ -j y
#$ -R y
#$ -w e

# email address to send notices to
##$ -M pusiol@stanford.edu
#$ -m beas

# set a name to make it easy to pick out of qstat output$
#$ -N BABYto

# if you need more than 1 slot on the same machine
##$ -pe fah 12

#memory request (if you want something other than default 4GB hard limit)
  ##$ -l h_vmem=XG



##echo "loading...."
##module load python

##echo "loading matlab" 
##module load MATLAB-R2012b

##echo ""
##echo "final list"
##module list

#/afs/ir.stanford.edu/software/matlab-2011b/bin/matlab  -r "directoryin='/afs/.ir/users/p/u/pusiol/Data/SIDEWALK/';directoryout='/afs/.ir/users/p/u/pusiol/Data/SIDEWALK-RESULTS/';"</afs/.ir/users/p/u/pusiol/prototypes-vision-ai/trunk/face-release1.0-basic/cornface.m

/afs/ir.stanford.edu/software/matlab-2011b/bin/matlab -r "directoryin='/mnt/glusterfs/pusiol/FaceData/OakesHeadcam40Videos/Original/CCB/';directoryout='/mnt/glusterfs/pusiol/FaceData/OakesHeadcam40Videos/Results/CCB/';"</afs/.ir/users/p/u/pusiol/prototypes-vision-ai/trunk/face-release1.0-basic/cornface.m

##/afs/ir.stanford.edu/software/matlab-2011b/bin/matlab  -r "directoryin='/mnt/glusterfs/pusiol/FaceData/ABCDEFGHI/';directoryout='/mnt/glusterfs/pusiol/FaceData/ABCDEFGHI-OUT/';"</afs/.ir/users/p/u/pusiol/prototypes-vision-ai/trunk/face-release1.0-basic/cornface.m

#just print the name of this machine
##nohup matlab -nodesktop demo.m directoryin='/hsgs/projects/mcfrank/Guido/Data/Face/XS_2008_objs/'  directoryout='/hsgs/projects/mcfrank/Guido/Data/Face/XS_2008_objs-Results/'
## /home/pusiol/prototypes-vision-ai/trunk/face-release1.0-basic/demo.m
