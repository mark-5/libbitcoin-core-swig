use strict;
use warnings;
use ExtUtils::CppGuess;
use ExtUtils::MakeMaker;
use File::Find;
use File::Spec::Functions qw(abs2rel catfile splitdir);

my @modules = find_swig_modules(catfile(qw(swig libbitcoin)));
local $ENV{SWIG_MODULES} = join(' ', @modules);

my @pls = find_pls('lib', 'src');
my @gen = exe_pls(@pls);
my @cpp = find_cpp('src');

my %args            = ExtUtils::CppGuess->new->makemaker_options;
$args{C}            = [catfile(qw(src libbitcoin.cpp)), @cpp];
$args{clean}        = {FILES => "\$(O_FILES) @gen"};
$args{CCFLAGS}     .= ' -std=c++11';
$args{dynamic_lib}  = {INST_DYNAMIC_DEP => 'swig_modules'};
$args{INC}          = '-I.';
$args{LIBS}         = '-lbitcoin -lboost_system';
$args{OBJECT}       = catfile(qw(src libbitcoin$(OBJ_EXT)));
$args{XS}           = {catfile(qw(src libbitcoin.xs)) => catfile(qw(libbitcoin.cpp))};
$args{XSOPT}        = '-hiertype -C++';

$args{ABSTRACT_FROM} = catfile(qw(lib libbitcoin.pm));
$args{VERSION_FROM}  = catfile(qw(lib libbitcoin.pm));
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
use File::Basename qw(basename);
use File::Spec::Functions qw(catfile);

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

sub postamble {
    return <<"__END__";
SWIGINSTDIR = \$(INST_ARCHAUTODIR)\$(DFSEP)
SWIGCPPDIR  = src\$(DFSEP)libbitcoin\$(DFSEP)
SWIGBASE    = @{[ map { (split('::', $_))[-1] } @modules ]}
SWIGLINKCMD = LD_RUN_PATH="\$(LD_RUN_PATH)" \$(LD) \$(LDDLFLAGS) \$(OTHERLDFLAGS)
SWIGLINKARG = \$(PERL_ARCHIVE) \$(LDLOADLIBS) \$(PERL_ARCHIVE_AFTER) \$(EXPORT_LIST) \$(INST_DYNAMIC_FIX)

swig_modules: \$(foreach base,\$(SWIGBASE),\$(SWIGCPPDIR)\$(base)_wrap\$(OBJ_EXT))
	\$(RM_F) \$(foreach base,\$(SWIGBASE),\$(SWIGINSTDIR)\$(base)_wrap)
	\$(MKPATH) \$(foreach base,\$(SWIGBASE),\$(SWIGINSTDIR)\$(base))
	\$(foreach base,\$(SWIGBASE),\$(SWIGLINKCMD) \$(SWIGCPPDIR)\$(base)_wrap\$(OBJ_EXT) -o \$(SWIGINSTDIR)\$(base)\$(DFSEP)\$(base).\$(DLEXT) \$(SWIGLINKARG);)
	\$(CHMOD) \$(PERM_RWX) \$(foreach base,\$(SWIGBASE),\$(SWIGINSTDIR)\$(base)\$(DFSEP)\$(base).\$(DLEXT))
__END__
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
