#!/usr/bin/perl
#This script takes input from a text file with list of hostnames to be masked. Along with that it also masks all IP addresses
#It has been tested only on CentOS and RHEL systems. Will not work on Windows

use strict;

my $time =  time;
my $nodelist = $ARGV[0];
my $script = $0;
if (not defined $nodelist) {
	die "Syntax: perl $script <Node File>\n";
}

open (READ, "$nodelist");
my @nodes = <READ>;
close READ;
my @logs = `ls logs/*`;

my $pwd = `pwd`;
$pwd =~  s/^\s+|\s+$//g;
my $file;
foreach $file (@logs) {
	$file =~  s/^\s+|\s+$//g;
	$file = "$pwd/$file";
	foreach (@nodes) {
		my $node = $_;
		$node =~ s/^\s+|\s+$//g;
		print "Removing entry $node from $file (if found)\n";
		`perl -p -i -e 's/$node/<removed host>/gi' $file`;

	}
	print "Removing all IP addresses from file $file\n";
	`perl -p -i -e 's\/(\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3})\/<removed IP>/g' $file`;	
}
my $log_zip = "log_$time.zip";
my $zip_command = "zip -r $log_zip logs";
print "Zipping logs dir to $log_zip\n";
print "Zipping using command $zip_command\n";

my $zip_results = `$zip_command`;
print "$zip_results\n";
