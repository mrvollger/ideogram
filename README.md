# ideogram

## Do an alignment, for example:
```
unimap -t {threads} --secondary=no -a --eqx -Y -x asm20 \
        -s 10000 -r 200000 \
         {input.ref} {input.asm} \
         | samtools view -F 260 -u - \
         | samtools sort -m {resources.mem}G -@ {threads} - \
         > {output.bam}
```
## Convert that alignmnet to a bed file 
```
bedtools bamtobed -i {output.bam} | bedtools sort -i - | cut -f 1,2,3,4,5 > {output.bed}
```
## Plot the bed file:  
```
Rscript ideogram.R --asm test_data/chm13.hifi.to.hg38.bed --plot chm13.pdf
```
(see `test_data/chm13.pdf` for example output)

## Plot two bed files:
Ideal for comparing two assemblies or two haplotypes.
```
Rscript ideogram.R --asm test_data/chm13.hifi.to.hg38.bed --asm2 test_data/AK1.to.hg38.bed --plot chm13_ak1.pdf
```
(see `test_data/chm13_ak1.pdf` for example output)




