#!/usr/bin/env perl
use strict;
use warnings;

my @modules = split(/\s+/, $ENV{SWIG_MODULES});

(my $outfile = __FILE__) =~ s/\.PL$//;
open STDOUT, '>', $outfile;

print <<"__END__";
package libbitcoin;
use strict;
use warnings;

our \$VERSION = '0.0.1';

require XSLoader;
XSLoader::load('libbitcoin');

@{[ map {"use $_;\n"} @modules ]}

1;
__END__
