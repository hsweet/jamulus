#!/usr/bin/perl -w
use strict;
use feature ':5.10';

# change to logfile on your system
# or start from command line .. usersperday.pl logfilename
my $logfile = $ARGV[0] || "bc.log";

#*************************************************************** 
my @connections = `grep connected  $logfile  | sed 's/,/ /g' | cut -d \" \" -f1`;
my $users = `cut -d , -f2 $logfile | sort | uniq | wc -l`;
my $days =  `cut -d , -f1 $logfile | cut -d " " -f1 $logfile |sort | uniq | wc -l`;
chomp $users;
chomp $days;
my $avg = $users/$days; 

my %dates;
foreach (@connections){ 
	while (/(\w[\w-]*)/g ){
		$dates{$1}++;
		} 
}

foreach my $day( sort keys %dates){
	say "$day $dates{$day}";
	}

say "-" x 60;	
say "You have had $users unique visitors in $days days";
print "An average of ";
printf("%.1f", $avg);
say " visitors per day";
say "-" x 60;
