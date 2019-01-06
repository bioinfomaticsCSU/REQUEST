#!/bin/sh
echo "Start !"
task=$2
FQ=$1
# error correction
corwrk=$FQ.cor_wrk
mecat2pw -j 0 -t 100  -x 1 -d $FQ -w $corwrk -o $corwrk.candidates.txt 
mecat2cns -i 0 -t 100 -x 1 -c 12 $corwrk.candidates.txt $FQ corrected.$FQ
# -i   input format, 0 = can, 1 = `M4
# -t  threads 
# -x 0 for Pacbio; -x 1 for Nanopore
# -c coverage
echo "Correction finish!"
rm -rf $FQ.cor_wrk 
rm *cor_wrk.candidates.*
# get features
python get_ft.py corrected.$FQ corrected.$FQ.ft 
python get_ft.py $FQ $FQ.ft 
echo "Get features !"
# scores,output:Sing_scores
Rscript score1_2.R corrected.$FQ.ft $FQ.ft 
# output: $FQ.ft.sqscore
# rename the reads ID
python rename.py $FQ $task
python fa2tab.py $task.fa $FQ.tab
paste $FQ.ft.sqscore $FQ.tab |sort -k1 -gr  > $FQ.score.sort.tab
python tab2fa.py  $FQ.score.sort.tab $task.score.sort.fa
rm  *.tab  $task.fa 
# no sort 
# paste $FQ.ft.sqscore $FQ.tab  > $FQ.score.tab
# python tab2fa.py  $FQ.score.tab $task.score.fa