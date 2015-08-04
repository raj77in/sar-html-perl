#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: cpugraph.pl
#
#        USAGE: ./cpugraph.pl  
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
#      CREATED: Tuesday 04 August 2015 02:04:30  IST
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;

#use CGI ':standard';

use GD::Graph::lines;
use GD::Graph::hbars;
use strict;

my (@data,@time,@utl) ;

my $i = 0 ;

open FILE, "cat /var/www/git/cgi-bin/out.txt |" || die $!;

# Both the arrays should same number of entries.

while(<FILE>) {

    next if($_ =~ /^\D/);
    next if($_ =~ m/@/);
    my @word = split(/\s+/, $_ );

    next if ($word[5] =~ m/^%/);

    $time[$i] = $word[0] ;

    $utl[$i] = $word[4] ;

    $i++ ;

}

@data = ([@time], [@utl]);

my $mygraph = GD::Graph::lines->new(1200, 600);

$mygraph->set(

    y_label => 'Memory Utilization in percentage',

    x_label => 'Time',

    title => 'Memory Utilization chart',

# Draw datasets in 'solid', 'dashed' and 'dotted-dashed' lines

    line_types => [1, 2, 4],

# Set the thickness of line

    line_width => 2,

# Set colors for datasets

    dclrs => ['red'],

    x_label_skip => 3,
    show_values => 1,
    values_format => "%55555f",
) or warn $mygraph->error;

$mygraph->set('x_labels_vertical'=> 1);

$mygraph->set_legend_font(GD::gdMediumBoldFont);

$mygraph->set_legend('Sar Output');

my $myimage = $mygraph->plot(\@data) or die $mygraph->error;

print "Content-type: image/png\n\n";

print $myimage->png;
