# Code for selecting UK Biobank participants to serve as control samples for genetic
# association tests of male FFA, specifically to serve as population controls for Greek
# FFA cases. This script:
#
#  1. Selects male UKB participants of European but non-UK country of birth, in order
#     to merge with FFA cases and perform PCA. The aim is to ensure that Greek FFA cases
#     cluster more closely with Greek UKB participants than participants from elsewhere 
#     in Europe (and similarly for Spanish, German and Italian FFA cases). This will give
#     confidence that there are not large batch effects between FFA cases and UKB controls
#     genotyped on different platforms.
#
#  2. Selects male UKB participants with Greece as country of birth. These participants
#     will be highlighted in the PCA plot described above, and will be eligible for
#     inclusion in the association test against Greek FFA cases.
#
# See also subsequent steps described at the end of this script


# df_subset is a data frame containing UK Biobank participant data in tabular format


library(dplyr)

# Filter out UK birth and retain other European countries and sex = male
df_eur_non_uk <- df_subset %>%
  filter(country_of_birth_nonuk_origin_f20115_0_0 != 354,
         between(country_of_birth_nonuk_origin_f20115_0_0, 300, 400),
         sex_f31_0_0 == "Male")

write.table(df_eur_non_uk,
            file = "file1.txt",    # Non-UK male European participants saved here
            sep = "\t",
            row.names = TRUE,
            col.names = NA)


# Retain Greek male participants only
greek.male <- subset(df_subset,
                     sex_f31_0_0 == "Male" &
                      (country_of_birth_nonuk_origin_f20115_0_0 == 322))$eid

View(greek.male)

write.table(greek.male,
            file = "greek_male_control.txt",
            sep = "\t",
            row.names = TRUE,
            col.names = NA)



# Next steps run in bash environment:
#
# - Extract all participants in file1.txt from UKB genotype array data, using
#   PLINK1.9 commands --keep and --make-bed
#
# - Convert variant IDs to chr:pos:a1:a2 format by editing .bim file for both
#   FFA cases and this UKB subset
#
# - Merge FFA cases and UKB subset using PLINK1.9 command --bmerge and identify
#   a subset of LD-independent markers, using the process described in the
#   repository https://github.com/ukb15147/ffa-gxe (script 3)
#
# - Perform PCA analysis using KING software with default parameters
#   (https://www.kingrelatedness.com/kingpopulation.shtml)


# Subsequently in R:
#
# - Plot PC1 vs PC2, colouring points for FFA cases of each of the four countries,
#   UKB participants from each of those four countries, and UKB participants
#   from all other non-European countries to provide a background PC space
#
#   - This plot demonstrated that cases and UKB participants from the same country
#     cluster together, suggesting no large batch effects


# In bash:
#
# - Further subset the genotype data (using PLINK1.9 with --keep) to include only
#   Greek male FFA cases and male UKB participants with Greece as country of birth.
#   Rerun PCA on this subset only
#
#   - Note that these PCA values will be included in the final association tests
#     as covariates


# In R:
#
# - Plot PCs for Greek cases and controls, and visually identify outliers to be
#   excluded from final analysis. This process identifies the final list of FFA
#   cases and UKB controls for association testing
