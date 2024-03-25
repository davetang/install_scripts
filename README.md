# README

Scripts to install tools from their source because sometimes I just want to install tools this way. However, I should add that there are better (because compiling can be a pain) ways to install tools than using my scripts. For example, using [Conda](https://anaconda.org/bioconda/samtools):

```console
conda install bioconda::samtools
```

Using [BioContainers](https://biocontainers-edu.readthedocs.io/en/latest/):

```console
docker run --rm quay.io/biocontainers/samtools:1.19.2--h50ea8bc_1 samtools --version
```
```
samtools 1.19.2
Using htslib 1.19.1
# output snipped
```
