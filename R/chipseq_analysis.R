# =================================================================
# ChIP-seq Analysis in R
# Author: Divya Mishra, Ph.D.
# =================================================================

library(ChIPseeker)
library(TxDb.Hsapiens.UCSC.hg38.knownGene)
library(DiffBind)
library(ggplot2)

# --------------------------
# 1. Peak annotation
# --------------------------
peak_file <- "results/peaks/sample1_peaks.narrowPeak"
peak <- readPeakFile(peak_file)
txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene

peakAnno <- annotatePeak(peak, tssRegion=c(-3000,3000), TxDb=txdb)
plotAnnoPie(peakAnno)
ggsave("results/figures/peak_annotation_pie.pdf")

# --------------------------
# 2. Differential binding analysis (DiffBind)
# --------------------------
samples <- read.csv("samplesheet.csv") # Define sample, condition, bam, peak files
dbObj <- dba(sampleSheet=samples)
dbObj <- dba.count(dbObj)
dbObj <- dba.contrast(dbObj, categories=DBA_CONDITION)
dbObj <- dba.analyze(dbObj)
dbReport <- dba.report(dbObj, method=DBA_EDGER)
write.csv(as.data.frame(dbReport), "results/DMRs/differential_binding.csv")

# --------------------------
# 3. Visualization
# --------------------------
pdf("results/figures/differential_binding_heatmap.pdf")
dba.plotHeatmap(dbObj, correlations=FALSE, scale="row")
dev.off()
