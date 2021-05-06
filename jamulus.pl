#!/usr/bin/perl
use strict;

# Starts multiple Jamulus servers on sequential ports, one for each name in the list 

my $port = 22216;     #port for first server, 22214 is Jamulus default
my @jams = qw[Upthecreek, Downriver];
 
foreach (@jams) {
        system("/usr/local/bin/Jamulus -T -s -n -p $port --norecord -o \"$_;Montreal;1+\" -w $_ &" );
        $port ++;
}

# -T=Multithread, -s=servermode, -n=nogui, -p=port, -o=serverlocation, -w=welcomemessage
