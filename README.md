This repository comprises code to support results derived using UK Biobank approved project 15147 that have been published in:

Rayinda _et al_, Shared Genetic Risk Variants in Both Male and Female Frontal Fibrosing Alopecia, _J Invest Dermatol_ (2023) 143(11):2311-2314.e5; [doi:10.1016/j.jid.2023.04.022](https://doi.org/10.1016/j.jid.2023.04.022) 

### Study lay summary

Frontal fibrosing alopecia (FFA) is a type of lichen planus causing scarring hair loss primarily in postmenopausal women, though a small percentage of cases are male. Previous research identified genetic links to xenobiotic metabolism and immune regulation in female FFA, but the genetic basis of male FFA remains underexplored. This study investigates male FFA genetics, focusing on loci previously associated with female FFA. In a cohort of 92 European ancestry affected males, and 330 ancestry-matched male controls, a significant association was found between male FFA and the HLA-B\*07:02 allele, mirroring findings in females. Additionally, a variant in the _CYP1B1_ gene, linked to estrogen metabolism, was associated with male FFA. These results suggest both shared and unique genetic factors in male and female FFA, warranting further research for deeper insights into FFA pathobiology across sexes.

### Data

Data for all FFA cases, and control genotype data for the Northern European and Spanish control cohorts, were sourced outwith UK Biobank. 

UK Biobank data cannot be openly shared, but researchers can apply for access.

Genetic analysis is based on the UK Biobank array genotype data (field 22418) after initial QC (see repository [https://github.com/ukb15147/central-scripts](https://github.com/ukb15147/central-scripts)) and genome-wide imputation. Eligible participants were selected from UKB using fields: "Sex" (field 31) and "Country of Birth (non-UK origin)" (field 20115).

### Code

| Script                                                         | Description                                                                                                                                                                                                                                                                                                                                             |
| -------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [1_select_greek_participants.R](1_select_greek_participants.R) | R script to identify participant IDs for males reporting their country of birth as Greece (eligible for inclusion as population controls), and all males reporting non-UK European country of birth (to check ancestry matching and rule out batch effects).<br><br>A summary of subsequent steps that use basic R and PLINK commands is also included. |
| [2_association_test.sh](2_association_test.sh)                 | bash script comprising PLINK commands for single variant and genetic risk score association tests                                                                                                                                                                                                                                                       |
