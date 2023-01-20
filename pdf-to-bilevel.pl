#!/usr/bin/perl
use warnings;
use strict;
use autodie;

my $pdf = shift @ARGV || die "Usage: $0 file.pdf";

if ( -d 'pages' ) {
	unlink $_ foreach glob 'pages/*';
} else {
	mkdir 'pages';
}

warn "# pdfimages $pdf";
system "pdfimages $pdf pages/p";

foreach my $page ( glob 'pages/p*' ) {
	my $cmd = "convert $page -compress Group4 -type bilevel $page.tiff";
	warn "## $cmd";
	system $cmd;
}

my @pages = glob 'pages/*.tiff';

warn "got ", scalar @pages, " pages";

# we need to batch 10 pages or convert will die with error
while ( @pages ) {
	my @batch = splice @pages, 0, 10;
	my $from = $1 if $batch[0]  =~ m/(\d+)/;
	my $to   = $1 if $batch[-1] =~ m/(\d+)/;
	my $cmd = "convert " . join(' ', @batch) . sprintf(" pages/b-%03d-%03d.pdf", $from, $to);
	warn "$cmd\n";
	system $cmd;
}

# finally use pdftk (since convert with 156 pages will die)
system "pdftk pages/b-*.pdf output $pdf.bilevel.pdf";
