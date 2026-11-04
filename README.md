# RNA-seq and ChIP-seq analysis of K562 and MCF7 cell lines

Graduate bioinformatics project, Rowan University, 2024: compare gene expression (RNA-seq) and POLR2A binding (ChIP-seq) in two cancer cell lines, K562 (chronic myelogenous leukemia) and MCF7 (breast cancer), using public ENCODE data aligned to hg19.

## What was done

| Step | Tool | Where |
|---|---|---|
| Read quality control | FastQC (desktop app) | not scripted |
| Read alignment to hg19 | Bowtie2 2.5.3 | `01`, `02` |
| SAM/BAM processing, filtering (MAPQ ≥ 30) | samtools 1.19.2 | `01`, `02` |
| Variant calling and statistics | bcftools 1.19 / 1.19.2 | `01` |
| Read inspection | IGV | not scripted |
| Transcript assembly and differential expression | Cufflinks 2.2.1 / Cuffdiff | see "Not included" |
| Functional enrichment | DAVID (web), Cytoscape with BiNGO | not scripted |
| ChIP-seq peak calling | MACS2 | `02` |
| Motif discovery | MEME Suite (MEME, STREME; web) | not scripted |

## Data (ENCODE accessions)

| Assay | Sample | Files |
|---|---|---|
| RNA-seq | K562 | ENCFF002DKA (read 1), ENCFF002DKE (read 2) |
| RNA-seq | MCF7 | ENCFF000HQR (read 1), ENCFF000HQP (read 2) |
| ChIP-seq POLR2A | K562 | ENCFF839LPL (read 1), ENCFF698ICA (read 2) |
| ChIP-seq control | K562 | ENCFF002EFD (read 1), ENCFF002EFA (read 2) |
| ChIP-seq POLR2A | MCF7 | ENCFF000SBI |
| ChIP-seq control | MCF7 | ENCFF000SAZ |

Reference: human genome hg19 (Bowtie2 prebuilt index and `hg19.fa`). Gene annotation: UCSC hg19 NCBI RefSeq GTF (`00_download_gene_annotation.sh`).

## Example output

Bowtie2 alignment of the K562 RNA-seq pair (ENCFF002DKA / ENCFF002DKE): 74,096,905 read pairs, 87.82% overall alignment rate.

## Scripts

`00_download_gene_annotation.sh`, `01_rnaseq_align_and_call_variants.sh` and `02_chipseq_align_and_call_peaks.sh` were reconstructed from my shell history. They list the commands that produced the results, with the failed attempts and typos removed. File paths are simplified to the current folder.

## Not included

- Cufflinks, Cuffmerge and Cuffdiff command lines: these steps were run outside the terminal sessions that were recorded, so the exact commands and options are not available.
- MACS2 for K562 and the alignment of the MCF7 ChIP samples were run in sessions that were not recorded.
- FastQC, IGV, DAVID, Cytoscape and MEME were used through their graphical or web interfaces.

## Tools

Bowtie2 2.5.3, samtools 1.19.2, bcftools 1.19, MACS2, FastQC, IGV, Cufflinks 2.2.1, DAVID, Cytoscape (BiNGO), MEME Suite.
