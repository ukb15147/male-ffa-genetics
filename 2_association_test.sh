# Prior to this script, genotype data for Greek male FFA cases and male UKB participants
# reporting country of birth as Greece have been merged, and genome-wide imputation
# performed


# Perform association test at chr 2, 6, 8 and 15 (which include established FFA loci).
# Uses PLINK 1.9; covariate_file.cov contains 2 principal components (see script 1)

plink \
  --allow-no-sex \
  --ci 0.95 \
  --const-fid 0 \
  --covar covariate_file.cov \
  --glm hide-covar cols=chrom,ref,nobs,ax,a1freq,orbeta,se,ci,p \
  --pheno male_greek_case_control.pheno \
  --pheno-name Phenotype \
  --vcf chr[2/6/8/15].dose.vcf.gz \
  --out chr[2/6/18/15]_greek_assoc


# Subsequent code uses a PLINK bed/bim/fam fileset (greek_male_FFA.*) that contains data
# merged across chromosomes.

# Perform association test with genetic risk score for Female FFA genome-wide significant variants
# Uses PLINK2.0; FFA_significant.txt contains 4 variants genome-wide significant in female FFA
# (derived from Tziotzios et al, Nat Commun 2019). Variants are listed in the publication

plink2 \
  --allow-no-sex \
  --bfile greek_male_FFA \
  --score FFA_significant.txt \
  --pheno male_greek_case_control.pheno \
  --pheno-name Phenotype \
  --out greek_significant_plink

# Aassociation test with genetic risk score for Female FFA genome-wide suggestive variants (P<1e-5)
# Uses PLINK2.0; FFA_suggestive.txt contains 28 variants genome-wide suggestive in female FFA
# (derived from Tziotzios et al, Nat Commun 2019). Variants are listed in the publication

plink2 \
  --allow-no-sex \
  --bfile greek_male_FFA \
  --score FFA_suggestive.txt \
  --pheno male_greek_case_control.pheno \
  --pheno-name Phenotype \
  --out greek_suggestive_plink
