#!/usr/bin/env bash
# RNA-seq: alignment to hg19, BAM processing and variant calling.
# Reconstructed from the shell history of the original run (macOS, zsh).
# Run from a folder that contains the FASTQ files, the Bowtie2 hg19 index
# (hg19.1.bt2 ... hg19.rev.2.bt2) and the reference FASTA hg19.fa.
# Tools used: Bowtie2 2.5.3, samtools 1.19.2, bcftools 1.19 / 1.19.2.
set -euo pipefail

# ---------------------------------------------------------------
# K562: ENCFF002DKA (read 1) + ENCFF002DKE (read 2)
# ---------------------------------------------------------------
A=ENCFF002DKA_DKE

bowtie2 -x hg19 \
  -1 ENCFF002DKA.fastq.gz -2 ENCFF002DKE.fastq.gz \
  -S ${A}_Aligned.sam

samtools view -bS ${A}_Aligned.sam > ${A}_Aligned.bam
samtools sort ${A}_Aligned.bam -o ${A}_Aligned_Sorted.bam
samtools index ${A}_Aligned_Sorted.bam

# Variant calling (run on the K562 sample only)
bcftools mpileup -Ov -f hg19.fa ${A}_Aligned_Sorted.bam -o ${A}_Aligned_Sorted_rawSNP.vcf
bcftools call -mv -Ov -o ${A}_Aligned_Sorted_calledSNP.vcf ${A}_Aligned_Sorted_rawSNP.vcf
bcftools stats ${A}_Aligned_Sorted_calledSNP.vcf > ${A}_Aligned_Sorted_calledSNP_stats.txt

# ---------------------------------------------------------------
# MCF7: ENCFF000HQR (read 1) + ENCFF000HQP (read 2)
# ---------------------------------------------------------------
B=ENCFF000HQR_HQP

bowtie2 -x hg19 \
  -1 ENCFF000HQR.fastq.gz -2 ENCFF000HQP.fastq.gz \
  -S ${B}_Aligned.sam

samtools view -bS ${B}_Aligned.sam > ${B}_Aligned.bam
# Keep reads with mapping quality >= 30 (used as the "uniquely aligned" set)
samtools view -q 30 -b ${B}_Aligned.bam > ${B}_UniquelyAligned.bam
