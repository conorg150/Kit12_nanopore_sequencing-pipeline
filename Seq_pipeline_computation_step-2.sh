#!/bin/bash

# USAGE:
# bash Seq_pipeline_computation_step-2.sh <sample name and barcode file with best contig> <Plasmid/Genome>

list=$(cut -f 1 < $1)
list1=$1

echo -e 'printing user selected best contigs to stdout for validation...\n'

#Takes the user specified 'best_contig' and searches the genome assembly for that contig, exports it to a fasta file with the sample name included, and then moves it to a 'best_contigs' directory
mkdir best_contigs

for i in $list ; do
    best_contig=$(awk -v i="$i" '$1==i {print $3}' $list1)
    echo $i $best_contig $2
    awk -v bc="$best_contig" -v i="$i" '$0 == ">"bc { match($1, /^>([^:]+)/, id); filename=i"_best-contig"} {print > filename".fa"}' $i/$i-genome/assembly.fasta
    mv $i\_best-contig.fa best_contigs/
    awk '/^>/{if(N)exit;++N;} {print;}' best_contigs/$i\_best-contig.fa > best_contigs/$i\_best-contig_$2.fa
    rm best_contigs/$i\_best-contig.fa
    done







 


