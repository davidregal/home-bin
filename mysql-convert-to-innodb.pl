#!/usr/bin/perl

use strict;
use warnings;

# Config
our $file_table_list = "/tmp/wings-tables.txt";
our $file_table_alter = "/tmp/wings-alter-tables.sql";

our $now = localtime;
print("Start: $now\n");
open(INFILE, "< $file_table_list");
open(OUTFILE, "> $file_table_alter");
foreach my $name (<INFILE>) {
   chomp($name);
   print OUTFILE "ALTER TABLE $name engine=InnoDB;\n";
}
close(INFILE);
close(OUTFILE);

$now = localtime;
print("End: $now\n");
