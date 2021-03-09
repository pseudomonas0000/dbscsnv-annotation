# dbscsnv-annotation

This can be to convert the dbscSNV1.1 datasets for annotation your vcf file by snpsift command `snpsift dbnsfp`.

## Requires 
* Perl(uses /usr/bin/env perl)
* bzgip and tabix (for compress and indexing)
* snpsift (for annotation vcf file)

## How to build
Frist, you need to download dbscSNV datasets [(site here)](http://www.liulab.science/dbscsnv.html) and uncompress `.zip` file.<br>
__NOTE: Save the umcompressed files in the repository directory.__<br>

Then for build like below (commandline aurgument is needed, set full path of header.txt). A `dbscSNV1.1.all.txt` file is created　and contained all the chromosome data.
```console
$ ./dbscsnv-convert.pl ./header.txt
```

## How to annotate datasets
Before annotate, you have to compress to `.gz` file by bgzip and indexing by tabix.<br>
Then, you can annotate the datasets created by this script using command `snpsift dbnsfp`  to your `.vcf` file (e.g. see below). If you want to know more infomation of command `snpsift dbnsfp`, check the help command `snpsift dbnsfp -h`.
```console
$ bgzip dbscSNV1.1.all.txt
$ tabix -s 1 -b 2 -e 2 dbscSNV1.1.all.txt.gz
$ snpsift dbnsfp -db ./dbscSNV1.1.all.txt.gz -f ada_score,rf_score your.vcf > annotated.vcf
```
<br>
Coded by pseudomonas0000, 2021/3/8


