<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

# Bacterial Co-occurrence-Networks-SparCC-tutorial
A framework and tutorial for building co-occurrence networks for bacterial communities using SparCC algorithm

# Building co-occurrence networks using bash and python

This framework is a tutorial for building co-occurrence networks for bacterial communities using the Sparse Correlations for Compositional Data ([SparCC](https://doi.org/10.1371/journal.pcbi.1002687)).

## Preparation

Firstly, you will need to install some environments.

If the enviroments are already installed, please jump to the next section.

-   `fastspar` : is the SparCC code writen in C++ to run in a bash environment
-   requirement: conda installed

<!-- -->
    ## Create and install the fastspar environment 
    conda create -n fastspar
    conda activate fastspar
    conda install -c bioconda fastspar

-   `python 2.7` : is a version of python required to be used in conda for some codes.

<!-- -->
    ## Create and install the py2.7 environment 
    conda create -n py27 python=2.7
    conda activate py27

## Building the networks

Create a directory for each network and change your otu_table to look like `example`.

You will need to have the [fastspar.sh](https://github.com/DpennaS/Co-occurrence-Networks-SparCC-tutorial/blob/main/docs/fastspar.sh) code in the master directory.

Now run the code bellow:

<!-- -->
    ## Activate fastspar environment
    conda activate fastspar

<!-- -->
    ## Run the fastspar in all directories
    for dir in */ ; do
        echo "Running fastspar.sh in directory $dir"
        (cd "$dir" && bash ../fastspar.sh)
    done

Leave this process running, depending on how many files you have it make take some time.

Now, we need to change some column names in 2 files in each directory `median_correlation2.tsv` and `pvalues2.tsv`. You will need to have the [rename_columns.sh](https://github.com/DpennaS/Co-occurrence-Networks-SparCC-tutorial/blob/main/docs/rename_columns.sh) in the master directory.

Therefore, run the [rename_columns.sh](https://github.com/DpennaS/Co-occurrence-Networks-SparCC-tutorial/blob/main/docs/rename_columns.sh) in the master directory.

<!-- -->
    ## Run the rename columns code
    ./rename_columns.sh

Now, we will activate the python environment

<!-- --> 
    ## Activate the python environment
    conda activate py27

In order to filter the significant correlations we will use the [get_significant_pairs.py](https://github.com/DpennaS/Co-occurrence-Networks-SparCC-tutorial/blob/main/docs/get_significant_pairs.py) in all directories. Therefore, you will need to have [get_significant_pairs.py](https://github.com/DpennaS/Co-occurrence-Networks-SparCC-tutorial/blob/main/docs/get_significant_pairs.py) code in the master directory.

<!-- -->
    ## Run the get_significant_pairs in all directories
    for dir in */ ; do
        echo "Running get_significant_pairs.py in directory $dir"
        (cd "$dir" && python2.7 ../get_significant_pairs.py)
    done

The final file is selected_cor.csv. You can run the [rename_selected_cor.sh](https://github.com/DpennaS/Co-occurrence-Networks-SparCC-tutorial/blob/main/docs/rename_selected_cor.sh) to rename each final file to the network directory name. Example: `b1.csv`.

<!-- -->
    ## Run the rename_selected_cor to change the directories names
    ./rename_selected_cor.sh

Now, there are some sofwares (e.g. gephi) that do not accept negative values in the weight of networks. Therefore, if you want, there is a code to add +1 in all weights and solve this problemn. You need to run the [adjust_weights.sh](https://github.com/DpennaS/Co-occurrence-Networks-SparCC-tutorial/blob/main/docs/adjust_weights.sh).

<!-- -->
    ## Run the adjust_weights to adjust the weight from networks with +1
    ./adjust_weights.sh

Your final files should be name.csv and name_cor_modified.csv. The `name` should be the network directory name, if you used the adjust_weights.sh code.

