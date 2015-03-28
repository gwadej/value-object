use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Value::Object',
    AUTHOR              => 'G. Wade Johnson <gwadej@cpan.org>',
    VERSION_FROM        => 'lib/Value/Object.pm',
    ABSTRACT_FROM       => 'lib/Value/Object.pm',
    LICENSE             => 'perl',
    PL_FILES            => {},
#   EXE_FILES           => [ 'bin/prog' ],
    PREREQ_PM => {
        'Test::More'       => 0,
        'Test::Exception'  => 0,
        'Moo'              => 0,
        'namespace::clean' => 0,
    },
    MIN_PERL_VERSION    => 5.008,
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Value-Object-*' },
    META_MERGE          => {
       'meta-spec' => { version => 2 },
       resources => {
           repository => {
               type => 'git',
               url  => 'https://github.com/gwadej/value-object.git',
               web  => 'https://github.com/gwadej/value-object',
            },
       },
    },
    test               => {
        TESTS => 't/*.t xt/*.t',
    },
);
