use strict;
use warnings;
use ExtUtils::CppGuess;
use ExtUtils::MakeMaker;
use File::Find;
use File::Spec::Functions qw(abs2rel splitdir);

my @modules = find_swig_modules('swig');
local $ENV{SWIG_MODULES} = join(" ", @modules);

my @pls = find_pls('lib', 'src');
my @gen = exe_pls(@pls);
my @cpp = find_cpp('src');

my %args        = ExtUtils::CppGuess->new->makemaker_options;
$args{C}        = ['src/libbitcoin.cpp', @cpp];
$args{clean}    = {FILES => "\$(O_FILES) @gen"};
$args{CCFLAGS} .= ' -std=c++11';
$args{INC}      = '-I.';
$args{LIBS}     = '-lbitcoin -lboost_system';
$args{OBJECT}   = '$(O_FILES)';
$args{XS}       = {'src/libbitcoin.xs' => 'src/libbitcoin.cpp'};
$args{XSOPT}    = '-hiertype -C++';

$args{ABSTRACT_FROM} = 'lib/libbitcoin.pm';
$args{VERSION_FROM}  = 'lib/libbitcoin.pm';
$args{NAME} = 'libbitcoin';

WriteMakefile(%args);


sub find_swig_modules {
    my ($dir) = @_;

    my @modules;
    find(sub {
        (my $file = $File::Find::name) =~ s/\.i$// or return;
        my $rel  = abs2rel($file, $dir);
        my @dirs = splitdir($rel);
        push @modules, join('::', splitdir($rel));
    }, $dir);

    return @modules;
}

sub find_pls {
    my (@dirs) = @_;

    my @pls;
    find(sub { push @pls, $File::Find::name if -x and /\.PL$/ }, @dirs);

    return @pls;
}

sub exe_pls {
    my (@pls) = @_;

    my @gen;
    for my $pl (@pls) {
        system $pl;
        (my $new = $pl) =~ s/\.PL$//;
        push @gen, $new;
    }

    return @gen;
}

sub find_cpp {
    my (@dirs) = @_;

    my @cpp;
    find(sub { push @cpp, $File::Find::name if /\.c(?:pp|xx)?$/ }, @dirs);

    return @cpp;
}

package
    MY;
use Config;

# append object file names to CCCMD
sub const_cccmd {
    my $self = shift;

    my $cccmd  = $self->SUPER::const_cccmd(@_);
    return q{} unless $cccmd;

    if ($Config{cc} =~ /\A cl \b /xmsi){
        $cccmd .= ' -Fo$@';
    }
    else {
        $cccmd .= ' -o $@';
    }

    return $cccmd
}

sub xs_c {
    my($self) = @_;
    my $mm = $self->SUPER::xs_c();
    $mm =~ s/ \.c /.cpp/xmsg;
    return $mm;
}
 
sub xs_o {
    my($self) = @_;
    my $mm = $self->SUPER::xs_o();
    $mm =~ s/ \.c /.cpp/xmsg;
    return $mm;
}
