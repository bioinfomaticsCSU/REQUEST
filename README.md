# REQUEST

REQUEST is a novel REad QUality Evaluation and Selection Tool (REQUEST) for evaluating the quality of third generation long reads.

## License

Copyright (C) 2018 Hongdong Li (hongdong@csu.edu.cn), Wenjing Zhang (wjzhang@csu.edu.cn)
School of Information Science and Engineering Central South University ChangSha CHINA, 410083

## Environment
- REQUEST
```
git clone https://github.com/bioinfomaticsCSU/REQUEST.git
PATH=$PATH:/home/.../REQUEST
# if not set the PATH. You can move the raw data into the REQUEST.
```
- R 
- Python 2.7+
- MECAT
```
git clone https://github.com/xiaochuanle/MECAT.git
cd MECAT
make 
cd 
PATH=$PATH:/home/.../MECAT/Linux-amd64/bin
```
## Data processing
 ### Input format
 REQUEST is capable of processing FASTA files, which contains 2 lines to  lines represent a read. You can download the test data: [MAP006-PCR-1_2D_pass.fasta](http://nanopore.s3.climb.ac.uk/MAP006-PCR-1_2D_pass.fasta)
 
 
 For example:
 ```
 >Reads_1
 GCCATGCTTCCGTTTCAGTTACGTATTGCTGTGGAAGCTGTCGGACGA
 ``` 
If not, you can use *fa2fa.py* to convert the format. Usage:
 ```
python fa2fa.py input.fa output.fa

Input fa:
>Reads_1
TTACGTATTG
CTGTGGAAGC
CTTCAT
>Reads_2
TGCGTAAAAG
GAGGCGGTTT
GCGGTGGCG

Output fa:
>Reads_1
TTACGTATTGCTGTGGAAGCCTTCAT
>Reads_2
TGCGTAAAAGGAGGCGGTTTGCGGTGGCG
```

 ### REQUEST pipeline
 You can use *REQUEST_main.sh* .
 ```
 sh REQUEST_main.sh input.fa task_name 
 ```
 
 ### Output files
 ***.ft**   *Each row represents the all 84 kinds of base rates and the length of a read.*
 
 ***.fa.ft.sqscore**   *the list of sqscores of the input fa_file.*
 
***.score.sort.fa**    *the reads with sqscores*.

As follows:
```
# >Task_ID_sqscore
>test_out.6778_5.713
CATCCGTCACCGTCAGCGGTGCGTAAAAGGAGGCGGT
>test_out.9672_4.799
GCCATGCTTCCGTTTCAGTTACGTATTGCTGTGGAAGG
>test_out.8701_4.083
ACTCAGGCGCGATGACCGGT
````
If you don't want a sorted file. You can rewrite the last part of *REQUEST_main.sh*.
```
# sort 
paste $FQ.ft.sqscore $FQ.tab |sort -k1 -gr  > $FQ.score.sort.tab
python tab2fa.py  $FQ.score.sort.tab $task.score.sort.fa
rm  *.tab  $task.fa 
# no sort 
paste $FQ.ft.sqscore $FQ.tab  > $FQ.score.tab
python tab2fa.py  $FQ.score.tab $task.score.fa
```
## Possible problems

- ***Segmentation fault***
This is generally because there are too many programs running at the same time, so you can change the *"-t 100"* into *"-t 20"* in the line 7 or 8  in the *REQUEST_main.sh* file.
