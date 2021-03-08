#!/usr/bin/env perl

use strict;
use warnings;

# Use module and function
use File::Copy qw/copy move/;

# Set a header file to the command line argument?
if($#ARGV < 0){
	print STDERR qq/No command line argument (header file)\n/;
	exit;
}
my $headerfile = $ARGV[0];


my @chrs = (1..22, "X", "Y");

# function: return a header infomation from the command line argument
sub get_header{
	my $headerfile = shift;
	open my $headerfh, "<", $headerfile 
		or die qq/Cannot open $headerfile : $!\n/;

	my $header;
	while(<$headerfh>){
		$header = $_ . "\n";
		last;
	}

	# print STDERR "$header";
	close($headerfh);
	return $header;
}

# Create temporary file
my $tmpfile = "header-change" . "_$$";
open my $tmpfh, ">", $tmpfile
	or die qq/Cannot open $tmpfile : $!\n/;

my $count = 0;
my $flag_header = 0;
for my $chr (@chrs){

	# Open and read each chromosome file
	my $infile = "dbscSNV1.1.chr$chr";
	open my $infh, "<", $infile
		or die qq/Cannot open $infile : $!\n/;

	while(<$infh>){
		if($flag_header == 0){
			my $new_header = get_header($headerfile);
			print $tmpfh "$new_header";
			$flag_header++;
			$count++;
			next;
		}

		if($_ =~ /^chr/){next;}

		print STDERR "Read\t$infile\trow #$count\n" if($count % 100000 == 0);

		print $tmpfh "$_";
		$count++;
	}
	$count = 0;
	close($infh);
}

# Temporary file replace to the output file
my $outfile = "dbscSNV1.1.all.txt";
move $tmpfile, $outfile 
	or die qq/Cannot move $tmpfile to $outfile: $!\n/;

