"""
ChIP-seq Analysis in Python
Author: Divya Mishra, Ph.D.
Purpose: Visualize QC, alignment metrics, and peak comparisons
"""

import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load alignment metrics or coverage
alignment_metrics = pd.read_csv("results/alignments/alignment_summary.csv")
sns.barplot(x='Sample', y='Aligned_reads', data=alignment_metrics)
plt.title("Alignment Metrics per Sample")
plt.savefig("results/figures/alignment_metrics.png", dpi=300)
plt.close()

# Optional: visualize peak distribution
peaks = pd.read_csv("results/peaks/sample1_peaks.narrowPeak", sep='\t', header=None)
peaks.columns = ["chr","start","end","name","score","strand","signalValue","pValue","qValue","peak"]
plt.figure(figsize=(8,5))
sns.histplot(peaks['score'], bins=50, kde=True)
plt.title("Peak Score Distribution")
plt.xlabel("MACS2 Peak Score")
plt.ylabel("Frequency")
plt.savefig("results/figures/peak_score_distribution.png", dpi=300)
plt.close()
