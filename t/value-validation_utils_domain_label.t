#!/usr/bin/env perl

use Test::More;

use strict;
use warnings;

use MooX::Value::ValidationUtils;

my @valid_labels = (
    [ 'a',  'single character label' ],
    [ 'A',  'Single upper character label' ],
    [ '1',  'single digit label' ],
    [ 'a-b', 'label containing a hyphen' ],
    [ 'a--b', 'label containing consecutive hyphens' ],
    [ 'a2b', 'label containing a digit' ],
    [ '2a',  'label starting with a digit' ],
    [ 'a2',  'label ending in a digit' ],
    [ '21',  'label consisting of just digits' ],
    [ 'abcdefghijklmnopqrstuvwxyz-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
        'Longest legal label' ],
);

my @invalid_labels = (
    [ undef,     'undefined' ],
    [ '',        'empty string' ],
    [ '-',       'label is just hyphen' ],
    [ '-aa',     'label starts with a hyphen' ],
    [ 'aa-',     'label ends with a hyphen' ],
    [ 'abcdefghijklmnopqrstuvwxyz-ABCDEFGHIJKLMNOPQRSTUVWXYZ-0123456789',
        'label > 63 octets' ],
);

plan tests => (@valid_labels+@invalid_labels);

foreach my $t (@valid_labels)
{
    ok( MooX::Value::ValidationUtils::is_valid_domain_label( $t->[0] ),
        "is_valid: $t->[1]"
    );
}

foreach my $t (@invalid_labels)
{
    ok( !MooX::Value::ValidationUtils::is_valid_domain_label( $t->[0] ),
        "!is_valid: $t->[1]"
    );
}
