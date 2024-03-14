# TidyMass

TidyMass is a tool designed for mass spectrometry data analysis that utilizes fragmentation trees. It computes these trees using data from tandem mass spectrometry (MS/MS) and matches fragment formulas to the peaks observed in the mass spectrum. Consequently, the mass spectrum is transformed into a series of fragments, enabling more detailed analysis.

## Requirements

Make sure you have the following tools installed:

* [Nextflow](https://www.nextflow.io/index.html#GetStarted)
* [conda](https://docs.anaconda.com/free/miniconda/miniconda-install/)

## Usage

```
./main.nf --input /some_path/sample.mgf --output ./results
```