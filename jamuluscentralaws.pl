#!/usr/bin/perl
use strict;

# ************************** Change values to match your event ***************** 
my $port = 22125;     #port for first server
my $path = "/usr/bin/jamulus";
my $location = "Montreal";
my $locale = "1+";
my $centralserverip = "3.97.xxx.xx";   #your public ip
my $centralname = "Up The Creek"; 
my $log =  "/var/log/jamulus/central.log";
my $msg = "<p>This server is part of the xxx Music Festival</p> <p>More text<\p>";
my @jams = qw[Jam1 Jam2 Jam3];
# ************************** end setup ***************************


# *********************** Central server****************************

system("$path -s -n -e 127.0.0.1  -l $log -o \"$centralname;$location;$locale\" -w \"Welcome to $centralname $msg\" &" );

# ************************ Client servers*************************** 
foreach (@jams) {
        # use server's public IP!
        system("$path -s -n -e $centralserverip -l $log -p $port -o \"$_;$location;$locale\" -w \"Welcome to  $_  $msg\" &" );
        $port ++;
}

