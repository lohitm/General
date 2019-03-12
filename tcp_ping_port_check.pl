#!/usr/bin/perl
#TCP ping for list of nodes and connectivity status for a particular port
#Author: Lohit Mohanta

use strict;
use warnings;
use Net::Ping;
use IO::Socket::INET;
use Term::ANSIColor;

#Add node file and port to check connectivity
my $nl='obr_nodes.txt';
my $port = 383;

open (READ,"$nl");
open (WRITE, ">obr_nodes_ping_383_results.txt");
chomp (my @nodes=<READ>);

my $host;
my @up_nodes;
my @down_nodes;
my @connection_accepted;
my @connection_refused;
my $port_status;
my $p = Net::Ping->new();

foreach $host (@nodes)
{
	my $socket = new IO::Socket::INET(
                PeerHost => $host,
                PeerPort => $port,
                Proto => 'tcp',
		Timeout => 2,
#               );
	);

        if ($socket) {
                $port_status="Connected";
		push @connection_accepted, $host;
        }
        else {
                $port_status="Refused";
		push @connection_refused, $host;
        }
	if($p->ping($host, 4)) {
    		print "$host,Up,$port_status\n";
    		print WRITE "$host,Up,$port_status\n";
		push @up_nodes, $host;
	
	}
	else {
		print "$host,Down,$port_status\n";
		print WRITE "$host,Down,$port_status\n";
		push @down_nodes, $host;
	}
#sleep(1);
print color('reset');
}
$p->close();

my $down_count=@down_nodes;
my $up_count=@up_nodes;

print "\n$down_count Down\n$up_count Up\n";
print "\nDown nodes: @down_nodes\n";
print "\nConnection Refused: @connection_refused\n\n";

