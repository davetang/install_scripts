# README

This repository contains scripts that install various tools that I use. Nowadays a lot of tools are distributed as static binaries, which are self-contained executables that includes all its dependencies compiled directly into the binary file itself. The only condition is that the appropriate binary is downloaded for your computer's architecture. Using a script to install these types of tools makes sense since you really just have to download the binary and sometimes the associated documentation.

Other tools need to be compiled on your computer and rely on shared libraries. This is sometimes very annoying because it's not immediately obvious which package should be installed to provide the necessary library files. Due to this, it is typically recommended to use something like Conda, which is a cross-platform package and environment management system that deals with tool dependencies for you. For example, here's how to use Conda to install [samtools](https://anaconda.org/bioconda/samtools):

```console
conda install bioconda::samtools
```

An other option to installing tools is to use containerisation software, like Docker or Singularity/Apptainer. Many tools are available as fixed images; here's how you can use Docker to install `samtools` using [BioContainers](https://biocontainers-edu.readthedocs.io/en/latest/):

```console
docker run --rm quay.io/biocontainers/samtools:1.19.2--h50ea8bc_1 samtools --version
```

Some of the scripts in this repository download the source files and try to compile the binary. This is fine for testing purposes but for bioinformatics workflows I would highly recommend using containerisation software to fix a tool. I have these scripts for the purpose of quickly installing a tool to perform testing and/or some preliminary analysis.
