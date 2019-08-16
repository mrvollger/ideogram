import sys

fmap = {
"chr1"	:"CM000663.2",
"chr2"	:"CM000664.2",
"chr3"	:"CM000665.2",
"chr4"	:"CM000666.2",
"chr5"	:"CM000667.2",	
"chr6"	:"CM000668.2",	
"chr7"	:"CM000669.2",	
"chr8"	:"CM000670.2",	
"chr9"	:"CM000671.2",	
"chr10"	:"CM000672.2",	
"chr11"	:"CM000673.2",	
"chr12"	:"CM000674.2",	
"chr13"	:"CM000675.2",	
"chr14"	:"CM000676.2",	
"chr15"	:"CM000677.2",	
"chr16"	:"CM000678.2",	
"chr17"	:"CM000679.2",	
"chr18"	:"CM000680.2",	
"chr19"	:"CM000681.2",	
"chr20"	:"CM000682.2",	
"chr21"	:"CM000683.2",	
"chr22"	:"CM000684.2",	
"chrX"	:"CM000685.2",
"chrY"	:"CM000686.2"
}
rmap = { val : key for key, val in fmap.items() }

pre = ""
rtn = ""
for line in open("asm.contigs.tiling"):
	line=line.strip()
	if(line[0] == ">"):
		pre = line[1:].split()[0]
		continue
	line = line.split()
	rtn += "{}\t{}\t{}\t{}\t60\n".format(rmap[pre], line[0], line[1], line[7])

sys.stdout.write(rtn)

