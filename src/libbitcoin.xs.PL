#!/usr/bin/env perl
use strict;
use warnings;

my @modules = split(/\s+/, $ENV{SWIG_MODULES});
s/::/__/ for @modules;

(my $outfile = __FILE__) =~ s/\.PL$//;
open STDOUT, '>', $outfile;

local $" = "\n";
print <<"__END__";
#ifdef __cplusplus
extern "C" {
#endif
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"
@{[ map { "XS(boot_$_);" } @modules ]}
#ifdef __cplusplus
};
#endif

MODULE = libbitcoin  PACKAGE = libbitcoin

BOOT:
@{[ map { "\tboot_$_(aTHX_ cv);" } @modules ]}

__END__
