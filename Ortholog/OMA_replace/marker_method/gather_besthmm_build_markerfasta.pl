#!env perl
use strict;
use warnings;

use Bio::DB::Fasta;
use Bio::SeqIO;
use Getopt::Long;
my $cutoff = 1e-40;
my $idir = 'out';
my $force = 0;
my $odir = 'DB/markers/fungi/marker_files';
my $ext = 'domtbl';
my $dbfile; # = 'DB/genomes/fungi';
my $debug = 0;
my $cdsdbfile; # optional for the extraction of CDS
my $basename = 0;
GetOptions('db|pep:s'    => \$dbfile,
	   'cds:s'    => \$cdsdbfile,
	   'v|debug!' => \$debug,
	   'o|out:s'  => \$odir,
	   'i|in:s'   => \$idir,
	   'ext:s'    => \$ext,
	   'basename!' => \$basename,
	   'cutoff|e|evalue:s' => \$cutoff,
	   'force!'   => \$force,
    );
my $db = Bio::DB::Fasta->new($dbfile);
mkdir($odir) unless -d $odir;
mkdir("$odir/aa") unless -d "$odir/aa";
mkdir("$odir/cds") unless -d "$odir/cds";

my $cdsdb;
if( $cdsdbfile ) {
    $cdsdb = Bio::DB::Fasta->new($cdsdbfile);
}
opendir(DIR, $idir) || die "cannot open $idir: $!";
my %hits_by_query;
for my $file ( readdir(DIR) ) {
    next unless $file =~ /(\S+)\.\Q$ext\E$/;
    my $p = $1;
    $p =~ s/\.TFASTX//;
    $p =~ s/\.v\d+//;
    my $hits = &get_best_hit_domtbl("$idir/$file");
    for my $h ( keys %$hits ) {
	$hits_by_query{$h}->{$p} = $hits->{$h};
    }
}
for my $marker ( keys %hits_by_query ) {
    next unless ($force || ! -f "$odir/$marker.aa");
    my $out = Bio::SeqIO->new(-format => 'fasta',
			      -file   => ">$odir/aa/$marker.aa");
    my $cdsout;
    if( $cdsdb ) {
	$cdsout = Bio::SeqIO->new(-format => 'fasta',
				  -file   => ">$odir/cds/$marker.cds");

    }
    while( my ($sp,$sn) = each %{$hits_by_query{$marker}} ) {
	my $s = $db->get_Seq_by_id($sn);
	if( ! $s ) {
	    warn("cannot find $sn ($marker) in AA db \n");
	    next;
	}
	if( $basename ) {
	    $s = Bio::Seq->new(-display_id => $sp,
			       -seq        => $s->seq,
			       -desc       => $s->display_id);
	}

	$out->write_seq($s);
	if( $cdsdb ) {
	    $s = $cdsdb->get_Seq_by_id($sn);
	    if( ! $s ) {
		warn("cannot find $sn ($marker) in CDS db\n");
		next;
	    }
	    if( $basename ) {
		$s = Bio::Seq->new(-display_id => $sp,
				   -seq        => $s->seq,
				   -desc       => $s->display_id);
	    }
	    $cdsout->write_seq($s);
	}
    }
}

sub get_best_hit_domtbl {
    my $file = shift;
    open(my $fh => $file) || die $!;
    my $seen;
    while(<$fh>) {
	next if /^\#/;
	my @row = split(/\s+/,$_);
	my $t = $row[0];
	my $q = $row[3];
	my $evalue = $row[6];
	next if $evalue > $cutoff;
	if( exists $seen->{$q} ) {
	    next;
	}
	$seen->{$q} = $t;
    }
    close($fh);
    return $seen;
}
