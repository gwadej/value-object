#!/usr/bin/env perl

use Test::More;

use strict;
use warnings;

use MooX::Value::ValidationUtils;

my @chars = (qw(a z A Z 0 9 !), '#', qw($ % & ' * + - / = ? ^ _ ` { | } ~));
my @valid_localpart = (
    ( map { [ $_, "Single character '$_' local part" ] } @chars),
    ( map { [ "ab${_}cd", qq(multicharacter local part with "$_") ] } @chars),
    ( map { [ "ab${_}cd.ef${_}gh", qq(two part local part with "$_") ] } @chars),
    [ 'abcdefghijklmnopqrstuvwxyz.ABCDEFGHIJKLMNOPQRSTUVWXYZ.0123456789', 'max 64 octet local part' ],
);

my @invalid_localpart = (
    [ undef,     'undefined' ],
    [ '',        'empty string' ],
    [ '.',       'no labels, just dot' ],
    [ '.foo',    'dot at beginning' ],
    [ 'a..foo',  'two dots in a row' ],
    [ 'foo.',    'dot at end' ],
    [ 'ab"cd',   'contains a double quote' ],
    [ 'ab@cd',   'contains an "@" character' ],
    [ 'ab(cd',   'contains an "(" character' ],
    [ 'ab)cd',   'contains an ")" character' ],
    [ 'ab\\cd',  'contains an "\\" character' ],
    [ 'ab[cd',   'contains an "[" character' ],
    [ 'ab]cd',   'contains an "]" character' ],
    [ 'ab:cd',   'contains an ":" character' ],
    [ 'ab;cd',   'contains an ";" character' ],
    [ 'ab,cd',   'contains an "," character' ],
    [ 'ab<cd',   'contains an "<" character' ],
    [ 'ab>cd',   'contains an ">" character' ],
    [ '!abcdefghijklmnopqrstuvwxyz.ABCDEFGHIJKLMNOPQRSTUVWXYZ.0123456789', 'over 64 octet local part' ],
);

plan tests => (@valid_localpart+@invalid_localpart);

foreach my $t (@valid_localpart)
{
    ok( MooX::Value::ValidationUtils::is_valid_email_local_part( $t->[0] ),
        "is_valid: $t->[1]: [$t->[0]]"
    );
}

foreach my $t (@invalid_localpart)
{
    ok( !MooX::Value::ValidationUtils::is_valid_email_local_part( $t->[0] ),
        "!is_valid: $t->[1]"
    );
}
