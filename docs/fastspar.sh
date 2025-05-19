#!/bin/bash

echo 'Correlation inference'
fastspar --threshold 0.5 --otu_table *.asv.tsv --correlation median_correlation2.tsv --covariance median_covariance.tsv

echo 'Fim'

echo 'calculation of p-values'

echo 'create bootstrap counts dir'

mkdir bootstrap_counts

echo 'boostrap'

fastspar_bootstrap --otu_table *.asv.tsv --number 1000 --prefix bootstrap_counts/asv

echo 'create bootstrap correlation dir'

mkdir bootstrap_correlation

echo 'parallel fastsapr'

parallel fastspar --otu_table {} --correlation bootstrap_correlation/cor_{/} --covariance bootstrap_correlation/cov_{/} -i 5 ::: bootstrap_counts/*

echo 'p-values calculation'

fastspar_pvalues --otu_table *.asv.tsv --correlation median_correlation2.tsv --prefix bootstrap_correlation/cor_asv_ --permutations 1000 --outfile pvalues2.tsv

echo ' Continue with get_signifance correlations'

echo 'FIM'
