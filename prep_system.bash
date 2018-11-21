#!/bin/bash

#run this on kollman

#WRITTEN BY WESLEY BOTELLO-SMITH, DEC. 14, 2017
#This fixes problems with parm7 and rst7 files that come from charmm-gui created AMBER
#simulations
#namely:
#1) The parm7 has "CHARMM" flags that must be converted to standard AMBER flags
#2) the rst7 file is (usually) an ncrst file and must be converted via cpptraj
#3) cpptraj writes a 10 column rst7 file which must be converted to the standard
#   six column format (via an awk script)
#After this, all that remains is to add the number of atoms to the rst7 file
#from there, you will need to continue on anton2 using the viparr commands as usual

module load AMBER/12

outcrd=`echo $2 | sed 's/[.].*//g'`
topfile=`echo $1 | sed 's/[.].*//g'`

echo "converting charmm-gui versions of AMBER topology and ncrst files to standard format"
cpptraj $1  <<-EOF
 trajin $2
 parmwrite out ${topfile}.vmd.prmtop
 trajout ${outcrd}.temp.rst7 nobox
EOF

awk -f fix_crd.awk ${outcrd}.temp.rst7 > ${outcrd}.vmd.rst7

echo "Next step is to open the .vmd.prmtop and .vmd.rst7 files in vmd"
echo "and add the number of atoms as the second line of the rst7 file"
echo ""
echo "these files can the mbe fed into the viparr-convert-prmtop.py script"
