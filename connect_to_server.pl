#!/usr/bin/perl  -I/usr/local/share/perl/5.20.2/
#===============================================================================
#
#         FILE: connect_to_server.pl
#
#        USAGE: ./connect_to_server.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: Tuesday 04 August 2015 02:04:04  IST
#     REVISION: ---
#===============================================================================

# use strict;
# use warnings;
# use utf8;

use Net::SSH::Expect;
use CGI ':standard';

my @CMDS;
$CMDS[1] = ("sar -q"); 

local ($buffer, @pairs, $pair, $name, $value, %FORM);
# Read in text
$ENV{'REQUEST_METHOD'} =~ tr/a-z/A-Z/;
if ($ENV{'REQUEST_METHOD'} eq "POST")
{
    read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
}else {
    $buffer = $ENV{'QUERY_STRING'};
}
# Split information into name/value pairs
@pairs = split(/&/, $buffer);
foreach $pair (@pairs)
{
    ($name, $value) = split(/=/, $pair);
    $value =~ tr/+/ /;
    $value =~ s/%(..)/pack("C", hex($1))/eg;
    $FORM{$name} = $value;
}

#hostname, userid and password extracted from webpage.

my $HOST = $FORM{hostname};
my $USER = $FORM{userid};
my $PWD = $FORM{pwd};
my $CMD= $CMDS[$FORM{sarc}];

open OUT, "> /var/www/git/cgi-bin/out.txt" or dir $!;

my $ssh = Net::SSH::Expect->new (
    host => "$HOST",
    password=> "$PWD",
    user => "$USER",
    raw_pty => 1
);

#Connect to server

$ssh->login();
my $sar_r = $ssh->exec("$CMD");


print "Content-type:text/html\r\n\r\n";
print "<html>";
print "<head>";
print "<title>Hello - Second CGI Program</title>";
print "</head>";
print "<body>";
#Print output of sar -r in OUT file
print  OUT $sar_r;
print "<meta http-equiv='Refresh' content='5;url=http://10.10.16.195/cgi-bin/cpugraph.pl' />";
print "</body>";
print "</html>";
