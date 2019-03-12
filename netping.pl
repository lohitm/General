#!/usr/bin/perl
#Update $nl with path to node list file

use strict;
use warnings;
use Net::Ping;

my $nl='nodes.txt';

open (READ,"$nl");
chomp (my @nodes=<READ>);
my $host;
my @up_nodes;
my @down_nodes;

my $p = Net::Ping->new("tcp");
foreach $host (@nodes)
{
	if($p->ping($host, 2)) {
    		print "$host:Ok\n";
		push @up_nodes, $host;
	
	}
	else {
		print "$host:Failed\n";
		push @down_nodes, $host;
	}
#sleep(1);
}
$p->close();

my $down_count=@down_nodes;
my $up_count=@up_nodes;

print "\n$down_count Down\n$up_count Up\n";
