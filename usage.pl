#!/usr/bin/perl -w
use strict;
use feature ':5.10';

# change to logfile on your system
# or start from command line .. usersperday.pl logfilename
my $logfile = $ARGV[0] || "aaron.log";
my $title = uc $logfile;
#***************************************************************
my @connections = `grep connected  $logfile  | sed 's/,/ /g' | cut -d \" \" -f1`;
my @hours = `grep connected $logfile | cut -d \" \" -f2 | cut -d : -f1 | sort`;
# How many users, for how many days
my $users = `cut -d , -f2 $logfile | sort | uniq | wc -l`;
my $days =  `cut -d , -f1 $logfile | cut -d " " -f1 $logfile |sort | uniq | wc -l`;
chomp $users;
chomp $days;
my $avg = $users/$days;

say "-" x 60;
say " -- $title -- Jamulus Usage -- ";
chomp $connections[0];
chomp $connections[-1];
say " -- $connections[0] -- $connections[-1] --";
say "-" x 60;
print "\n";
# ************************** Daily Usage *****************************
#    hash to acculmulate number of not necessarily unique connections per day
my %dates;
say "Date        Visitors";
foreach (@connections){
	while (/(\w[\w-]*)/g ){
		$dates{$1}++;
 		}
}

foreach my $day( sort keys %dates){
	say "$day  $dates{$day}";
	}
# **************************  Hourly Usage *****************
print "\n";
say "-" x 60;
print "\n";
say "Hour     Visitors";
my %hourly;
foreach (@hours){
  while (/(\w{2})/g ){
		$hourly{$1}++;
		}
}

foreach my $hour( sort keys %hourly){
	# add a , beteen fields for quick cvs import
	say"$hour:00    $hourly{$hour}";
	}

# ************************** Totals **********
print "\n";
say "-" x 60;
say "You have had $users unique visitors in $days days";
print "An average of ";
printf("%.1f", $avg);
say " visitors per day";
say "-" x 60;
