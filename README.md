# ideogram

## Alignment command
```
minimap2 -t {threads} --secondary=no -a --eqx -Y -x asm20 \
        -m 10000 -z 10000,50 -r 50000 --end-bonus=100 -O 5,56 -E 4,1 -B 5 \
         {input.ref} {input.asm} | samtools view -F 260 -u - | samtools sort -m {resources.mem}G -@ {threads} - > {output.bam}
bedtools bamtobed -i {output.bam} | bedtools sort -i - | cut -f 1,2,3,4,5 > {output.bed}
```


## Test cases / examples 
For one assembly:
```
Rscript ideogram.R --asm test_data/chm13.hifi.to.hg38.bed --plot chm13.pdf
```
compare with ```test_data/chm13.pdf```

For two assemblies:
```
Rscript ideogram.R --asm test_data/chm13.hifi.to.hg38.bed --asm2 test_data/AK1.to.hg38.bed --plot chm13_ak1.pdf
```
compare with ```test_data/chm13_ak1.pdf```




