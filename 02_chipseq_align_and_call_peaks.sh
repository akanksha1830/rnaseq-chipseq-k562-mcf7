#!/usr/bin/env bash
# POLR2A ChIP-seq: alignment to hg19, filtering, MACS2 peak calling.
# Reconstructed from the shell history of the original run (macOS, zsh).
# Tools used: Bowtie2 2.5.3, samtools 1.19.2, MACS2.
set -euo pipefail

# ---------------------------------------------------------------
# K562: POLR2A ChIP and control (paired-end), aligned to hg19
# ---------------------------------------------------------------
bowtie2 -x hg19 \
  -1 K562_POLR2A_R1_ENCFF839LPL.fastq.gz -2 K562_POLR2A_R2_ENCFF698ICA.fastq.gz \
  -S K562_POLR2A_ENCFF839LPL_ICA_Aligned.sam

bowtie2 -x hg19 \
  -1 K562_Control_R1_ENCFF002EFD.fastq.gz -2 K562_Control_R2_ENCFF002EFA.fastq.gz \
  -S K562_Control_ENCFF002EFD_EFA_Aligned.sam

# SAM -> BAM, MAPQ >= 30 filter, sort. The sort step is inferred from the
# file names used downstream (*_UniquelyAligned_Sorted.bam).
for S in K562_POLR2A_ENCFF839LPL_ICA K562_Control_ENCFF002EFD_EFA; do
  samtools view -bS ${S}_Aligned.sam > ${S}_Aligned.bam
  samtools view -q 30 -b ${S}_Aligned.bam > ${S}_UniquelyAligned.bam
  samtools sort ${S}_UniquelyAligned.bam -o ${S}_UniquelyAligned_Sorted.bam
done

# ---------------------------------------------------------------
# MCF7: peak calling on filtered, sorted BAMs
#   ChIP:    MCF7_POLR2A_ENCFF000SBI_UniquelyAligned_Sorted.bam
#   Control: MCF7_Control_ENCFF000SAZ_UniquelyAligned_Sorted.bam
# NOTE: the history line was cut off at "-p 0.00". The report states a
# threshold of -log10(p) = 5, so -p 1e-5 is used here. Confirm before relying on it.
# ---------------------------------------------------------------
macs2 callpeak \
  -t MCF7_POLR2A_ENCFF000SBI_UniquelyAligned_Sorted.bam \
  -c MCF7_Control_ENCFF000SAZ_UniquelyAligned_Sorted.bam \
  -f BAM --outdir MCF_POLR2A -n MCF7_POLR2A -p 1e-5
