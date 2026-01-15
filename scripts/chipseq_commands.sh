#!/bin/bash
# =================================================================
# ChIP-seq Workflow: Adapter trimming, alignment, deduplication, peak calling
# Author: Divya Mishra, Ph.D.
# =================================================================

# 1. Adapter trimming
trim_galore --paired data/raw/sample1_R1.fastq.gz data/raw/sample1_R2.fastq.gz -o results/trimmed/

# 2. Quality check
fastqc results/trimmed/sample1_R1_val_1.fq.gz results/trimmed/sample1_R2_val_2.fq.gz -o results/qc/
multiqc results/qc/ -o results/qc/

# 3. Alignment to reference genome
bowtie2 -x /path/to/genome_index \
        -1 results/trimmed/sample1_R1_val_1.fq.gz \
        -2 results/trimmed/sample1_R2_val_2.fq.gz \
        -S results/alignments/sample1.sam

# 4. Convert SAM to sorted BAM
samtools view -Sb results/alignments/sample1.sam | samtools sort -o results/alignments/sample1_sorted.bam
samtools index results/alignments/sample1_sorted.bam

# 5. Remove PCR duplicates
picard MarkDuplicates I=results/alignments/sample1_sorted.bam \
                      O=results/alignments/sample1_sorted_dedup.bam \
                      M=results/alignments/sample1_dup_metrics.txt \
                      REMOVE_DUPLICATES=true

# 6. Peak calling with MACS2
macs2 callpeak -t results/alignments/sample1_sorted_dedup.bam \
               -c results/alignments/control_sorted_dedup.bam \
               -f BAM -g hs -n sample1 --outdir results/peaks
