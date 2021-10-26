#!/usr/bin/perl

add_cus_dep( 'acn', 'acr', 0, 'makeglossaries' );
add_cus_dep( 'glo', 'gls', 0, 'makeglossaries' );
$clean_ext .= " acr acn alg glo gls glg";
sub makeglossaries {
  my ($base_name, $path) = fileparse( $_[0] );
  pushd $path;
  my $return = system "makeglossaries", $base_name;
  popd;
  return $return;
}


# Run pdfannotextractor on the included pdf files
my $dir = 'appendices/assets';
my $texmfdist = `kpsewhich -var-value TEXMFDIST`;
my $texmfvar = `kpsewhich -var-value TEXMFVAR`;
$texmfdist =~ s/\n//g;
$texmfvar =~ s/\n//g;
my $paxscript = $texmfdist.'/scripts/pax/pdfannotextractor.pl';

if (!-d $texmfvar) {
	system('mkdir', '-p', $texmfvar);
}

if (not my @files = glob "$dir/*.pax"){
	system($paxscript, '--install');
}

my @files = glob "$dir/*.pdf";
for (0..$#files){
	system($paxscript." ".$files[$_]);
}
