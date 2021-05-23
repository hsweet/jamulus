# Automatically starts a Jamulus Central Server and as many client servers as needed for a branded event.
# Client servers can run from the same system as the central, or be registered from other systems.
# On Linux server, run from a systemd control file

# ******************************************* Setup ****************
my $port = 22125;     #port for first server
my $path = "/usr/bin/jamulus";
my $location = "Montreal";
my $locale = "1+";
my $centralserverip = "x.xxx.xx.x";   #public ip
my $centralname = "Up The Creek";
my $log =  "/var/log/jamulus/central.log";
my $recordpath = "tmp/jamulusrecording";
my $channels = 12;  #max number of musicians
my $msg = "<p>Welcome to the 2021 Black Creek Old Time Music Festival</p>";
my @jams = qw[Sheeep_Barn]; #Slo Grainery SheepBarn
my $centralmsg =  <<"CENTRAL_INSTRUCTIONS";
<hr>
<h2>Looking for the other rooms?</h2>
<ol>
<li>Put the ip address x.xx.xxx.x in the <em>Custom Central Server Address</em> field of the <em>Settings</em> dialog box.</li>
<li>Go to <em>Connection Setup</em> in the  <em>View menu</em>  to see the list of jams</li>
<li>Choose <em>Custom</em> from the <em>List Menu</em></li>
</ol>
<hr>
Click <a href = "https://docs.google.com/document/d/...."> HERE</a> for further instructions.
CENTRAL_INSTRUCTIONS

# *********************** Central server****************************

system("$path -s -n -e 127.0.0.1  -l $log -u $channels -R $recordpath --norecord -o \"$centralname;$location;$locale\" -w \"<h2>$centralname<\/h2> $msg $centralmsg\" &" );

# ************************ Client servers***************************
foreach (@jams) {
        # use server's public IP!
        system("$path -s -n -e $centralserverip -l $log -u $channels -R $recordpath --norecord -p $port -o \"$_;$location;$locale\" -w \"<h2> $_ <\/h2>  $msg\" &" );
        $port ++;
}
(END)


#
