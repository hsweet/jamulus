#!/usr/bin/perl
use strict;

#system ("killall Jamulus");     # for testing only

# ************************** change values to match your event***************** 
my $port = 22125;     #port for first server
# my $path = "/usr/bin/jamulus";
my $path = "/usr/local/bin/Jamulus";
my $location = "Montreal";
my $locale = "1+";
my $centralserverip = "192.168.1.224"; #"3.97.132.10";   #public ip
my $centralname = "Up The Creek"; 
my $log =  "central.log";  #"/var/log/jamulus/central.log";
my $msg = "<p>This server is part of the Black Creek Old Time Music Festival</p> <p>Memorial day since time immemorial<\p>";
my @jams = qw[C-Tunes D-Tunes G-Tunes A-Tunes];
# ************************** end setup ***************************

# *********************** Central server****************************

system("$path -s -n -e 127.0.0.1  -l $log -o \"$centralname;$location;$locale\" -w \"Welcome to $centralname $msg\" &" );

# ************************ Client servers*************************** 
foreach (@jams) {
        # use server's public IP!
        system("$path -s -n -e $centralserverip -l $log -p $port -o \"$_;$location;$locale\" -w \"Welcome to  $_  $msg\" &" );
        $port ++;
}

