# deepDTnet
## paper "Target Identification among Known Drugs by Deep Learning from Heterogeneous Networks"


### Quick start
we provide an example script to run experiments with the features already extracted from our dataset:
- Run `run_deepDTnet.m`: predict drug-target interactions, and evaluate the results with cross-validation.
**Note:** See the "Tutorial" section below for a detailed instruction on how to run deepDTnet on your own dataset.


### Code and data
#### `src/` directory
- `auc.m`: evaluation script
- `compute_similarity.m`: compute Jaccard similarity based on association network(i.e., drug-disease, drug-side-effect, and protein-disease networks)
- `imf_train.mexa64`: pre-built binary file of PU-Matrix Completion algorithm 
- `PUMC.m`: predict drug-target interactions (DTIs) with PU-Matrix Completion
- `run_deepDTnet.m`: example code of running deepDTnet for drug-target prediction

#### `data/` directory
- `drug_dict.txt`: list of drug unique identifier and drug names
- `protein_dict.txt`: list of protein unique identifier and protein names
- `disease_dict.txt`: list of disease unique identifier and disease names
- `se_dict.txt`: list of side effect unique identifier and side effect names
- `drugdrug.txt`: Drug-Drug interaction matrix
- `drugDisease.txt`: Drug-Disease association matrix
- `drugsideEffect.txt`: Drug-SideEffect association matrix
- `drugsim1network.txt`: Drug chemical similarity matrix
- `drugsim2network.txt`: Drug therapeutic similarity matrix
- `drugsim3network.txt`: Drug sequence similarity matrix
- `drugsim4network.txt`: Drug biological processes similarity matrix
- `drugsim5network.txt`: Drug cellular component similarity matrix
- `drugsim6network.txt`: Drug molecular function similarity matrix
- `proteinprotein.txt`: Protein-Protein interaction matrix
- `proteinDisease.txt`: Protein-Disease association matrix
- `proteinsim1network.txt`: Protein sequence similarity matrix
- `proteinsim2network.txt`: Protein biological processes similarity matrix
- `proteinsim3network.txt`: Protein cellular component similarity matrix
- `proteinsim4network.txt`: Protein molecular function similarity matrix

#### `feature/` directory
We provided the pre-trained vector representations for the 15 networks, which were used to produce the results in our paper.

#### `DNGR/` directory
This directory contains code necessary to run the DNGR algorithm.
- Run `main.m`: an example script to generate a low-dimensional vector representation of features for each node in the Drug chemical similarity network.
**Note:** For different networks, you need to fine tune the parameters in `BuildNets.m`.
The original version of this code base was originally from http://shelson.top/, and we owe many thanks to Shaosheng Cao for making his code available.

#### `supplementary/` directory
- `Supplementary_Table_3.xlsx`: an excel table including 4,978 experimentally validated drug-target interactions connecting 732 approved drugs and 1,915 human targets.
- `Supplementary_Table_4.xlsx`: an excel table including all target lists for G-protein-coupled receptors (GPCRs), kinases, nuclear receptors (NRs), and ion channels (ICs).
- `Supplementary_Table_5.xlsx`: an excel table including novel drug-target interactions predicted by deepDTnet with score above the threshold.


### Tutorial
We test the code on Ubuntu 16.04 with Matlab R2016a installed
1. Put interaction/association/similarity matrices in the `data/` folder.
2. Create a `simNet/` folder under `deepDTnet/` and run `compute_similarity.m` in the `src/` folder, which will compute the Jaccard similarity of drugs and proteins, based on the three association matrices mentioned above.
3. run `main.m` in the `DNGR/core` folder for 2 interaction networks ,10 similarity networks in the `data/` folder and 3 similarity networks in the `simNet/` folder, which will learn the feature vectors of drugs and proteins for the 15 networks and save them in the `feature/` folder.
4. Specify parameters and set the path of feature vectors in `run_deepDTnet.m` and execute it. This script will predict the drug-target interactions and evaluate the results using a five-fold cross-validation.
