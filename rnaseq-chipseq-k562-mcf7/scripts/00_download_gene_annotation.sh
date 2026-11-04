#!/usr/bin/env bash
# Gene annotation (hg19, NCBI RefSeq) downloaded from UCSC.
# Reconstructed from the shell history of the original run.
set -euo pipefail

wget https://hgdownload.cse.ucsc.edu/goldenpath/hg19/bigZips/genes/hg19.ncbiRefSeq.gtf.gz
gunzip hg19.ncbiRefSeq.gtf.gz
mv hg19.ncbiRefSeq.gtf hg19_ncbiRefSeq_annotation.gtf
