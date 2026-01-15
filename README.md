# ChIP-seq Analysis Pipeline

**Author:** Dr. Divya Mishra, Ph.D.  
**Expertise:** Molecular Genetics, NGS Data Analysis, Clinical Genomics

---
## Overview
This repository provides an **end-to-end ChIP-seq pipeline**, covering:
- Raw data QC and trimming
- Alignment to reference genome
- Deduplication of BAM files
- Peak calling using MACS2
- Peak annotation (ChIPseeker)
- Differential binding analysis (DiffBind)
- QC and visualization (R & Python)
- Publication-ready plots and tables

## Repository Structure
```
ChIPseq_analysis/
├── README.md
├── data/raw/ # Raw FASTQ files
├── results/qc/
├── results/trimmed/
├── results/alignments/
├── results/peaks/
├── results/DMRs/
├── results/figures/
├── scripts/chipseq_commands.sh
├── R/chipseq_analysis.R
└── Python/chipseq_analysis.py
```
## Running the Pipeline

### Bash Alignment & Peak Calling
```bash
bash scripts/chipseq_commands.sh

R Peak Annotation & Differential Binding
Rscript R/chipseq_analysis.R

Python QC & Visualization (Optional)
python Python/chipseq_analysis.py
```
### Requirements
```
Command-line: Bismark, Bowtie2, Trim Galore!, FastQC, MultiQC, MACS2, Picard
R: ChIPseeker, TxDb.Hsapiens.UCSC.hg38.knownGene, DiffBind, ggplot2
Python: pandas, matplotlib, seaborn
```
### Outputs
```
BAM files (aligned, sorted, deduplicated)
QC reports
MACS2 peak files
DMRs and differential binding CSVs
Figures for visualization
