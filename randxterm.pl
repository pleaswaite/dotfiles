#!/bin/perl
# Matt Brodeur <mbrodeur@nexttime.com>
# Updated with work from Sean Waite <swaite@redhat.com>
# Which was based on original randxterm.pl by <mbrodeur@redhat.com>

use constant DEBUG => 0;
use constant VERBOSE => 0;
use constant CONTRAST => 5.0;

use warnings;
use strict;

# Check whether we have a module that we'd like to use
my $have_which;
if (eval {require File::Which;1;}) {
	File::Which->import();
	$have_which = 1;
} else {
	warn "File::Which not found. You're on your own.\n" if VERBOSE;
}


my $xterm_geometry = "90x45";

my @colors;
my $xterm_command;
my $showrgb;
my $fgcolor;
my $bgcolor;


# If we have File::Which, find the external commands we need
if ($have_which) {
	$xterm_command =  which("xterm");
	warn "\$xterm_command = $xterm_command \n" if DEBUG;
	die "xterm not installed.\n" unless $xterm_command;

	$showrgb = which("showrgb");
	warn "\$showrgb = $showrgb \n" if DEBUG;
	die "showrgb not installed.\n" unless $showrgb;
} else {
	# Try a few likely paths
	# OS X, then most Linuxes
	foreach my $binpath (qw(/opt/X11/bin /usr/bin /bin)) {
		my $bintest = $binpath . "/xterm";
		$xterm_command = $bintest if (-X $bintest);
		$bintest = $binpath . "/showrgb";
		$showrgb = $bintest if (-X $bintest);
	}
	#warn "File::Which not available, and one or more binaries not found in likely locations.\n" if DEBUG;
	#warn "I hope xterm and showrgb are installed and in PATH.\n" if DEBUG;
	$xterm_command = "xterm" if (! defined($xterm_command));
	$showrgb = "showrgb" if (! defined($showrgb));

	warn "showrgb will be tried at $showrgb\n" if DEBUG;
	warn "xterm will be tried at $xterm_command\n" if DEBUG;
} # end of binary hunt


# Populate @colors as an array of hashes with names and RGB values
open(RGBDB, "$showrgb|") || die "$!\n";
while (<RGBDB>) {
	warn "$_" if DEBUG;
	chomp;
	my ($RV,$GV,$BV,@colorname)=split;
	push @colors, { colorname => "@colorname", red => $RV, green => $GV, blue => $BV };
	warn "@colorname\n" if DEBUG;
}
close(RGBDB);


my $colortests=0;
my $flag = 0;
while ($flag != 1)
{
	$colortests++;
	# grab two random color indexes
	my $fgcolornum = rand @colors;
	# keep trying until they're different
	#until ((my $bgcolornum = rand @colors) != $fgcolornum) {};
	my $bgcolornum = rand @colors;

	# crazy luminance calculation
	my $LA = (0.2126 * (($colors[$fgcolornum]{red} / 255) ** 2.2)) +
		(0.7152 * (($colors[$fgcolornum]{green} / 255) ** 2.2)) +
		(0.0722 * (($colors[$fgcolornum]{blue} / 255) ** 2.2));

	my $LB = (0.2126 * (($colors[$bgcolornum]{red} / 255) ** 2.2)) +
		(0.7152 * (($colors[$bgcolornum]{green} / 255) ** 2.2)) +
		(0.0722 * (($colors[$bgcolornum]{blue} / 255) ** 2.2));

	# calculate contrast
	my $testcontrast;
	if ($LA >= $LB)
	{
		$testcontrast = (($LA + .05) / ($LB + .05));
	} else {
		$testcontrast = (($LB + .05) / ($LA + .05));
	}
	if ( $testcontrast >= CONTRAST ) { $flag = 1; }

	$fgcolor = $colors[$fgcolornum]{colorname};
	$bgcolor = $colors[$bgcolornum]{colorname};

	warn "Attempt $colortests: Tried $fgcolor on $bgcolor " .
	"with a contrast of $testcontrast\n" if VERBOSE;
}


# Finally, run the xterm command with the selected colors and any
# extra options from the command line.
warn "@ARGV \n" if DEBUG;
$xterm_command = $xterm_command . " " .
"+sb -fg \"$fgcolor\" -bg \"$bgcolor\" " .
"-fa 'Mono-10' -geometry \"$xterm_geometry\" @ARGV";
warn "$xterm_command\n" if VERBOSE;
exec $xterm_command;
