#!/usr/bin/env Rscript

library(ggplot2)
library(scales)
library(RColorBrewer)
library(plyr)
library(grid)
library(gridBase)
library(gridExtra)
library(data.table)
library(gtable)
#source("http://bioconductor.org/biocLite.R")
#biocLite("karyoploteR")
library(karyoploteR)
library(GenomicRanges)
suppressPackageStartupMessages(library("argparse"))
library(argparse)


# create parser object
parser <- ArgumentParser()
parser$add_argument("-a", "--asm",  help="bed file with all the asm mapping")
parser$add_argument("-b", "--asm2",  help="bed file with a second asm mapping")
parser$add_argument("-p", "--plot",  help="output plot, must have .pdf ext.")
args <- parser$parse_args()


asmdf<- function(filename, colors){
  asmvshg = read.table(filename, header=F)
  names(asmvshg) = c("chr", "start", "end", "name", "xqual")
  curcolor = 1
  lencolors = length(colors)
  precontig = ""
  asmcolor = NULL
  y = NULL
  for(i in 1:nrow(asmvshg) ){
    contig = as.character(asmvshg$name[i])
    if(contig != precontig){
      curcolor = (curcolor + 1) %% lencolors 
      precontig = contig
    }
    asmcolor = c(asmcolor, colors[curcolor + 1])
    y = c(y, curcolor/4)
  }
  asmvshg$color = asmcolor
  asmvshg$y = y
  asmvshg$y1 = asmvshg$y + .25
  return(asmvshg)
}

asmvshg = asmdf(args$asm,  c("#2081f9", "#f99820") ) 

if(!is.null(args$asm2)){
  asmvshg2 = asmdf(args$asm2,  c("#159934", "#99157a") )
}


cex = 0.5 

print("Plotting") 

pdf(file=args$plot, width = 9, height =16 )

if(is.null(args$asm2)){
  kp <- plotKaryotype(genome="hg38")
} else {
  kp <- plotKaryotype(genome="hg38", plot.type = 2)
}

# adding asm bed number one
kpRect(kp, chr=asmvshg$chr, x0=asmvshg$start, x1=asmvshg$end, y0=asmvshg$y, y1=asmvshg$y1, col=asmvshg$color)

# adding second asm if there
if(!is.null(args$asm2)){
  kpRect(kp, chr=asmvshg2$chr, x0=asmvshg2$start, x1=asmvshg2$end, y0=asmvshg2$y, y1=asmvshg2$y1, col=asmvshg2$color, data.panel = 2)
}

dev.off()




