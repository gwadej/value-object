#!/usr/bin/env perl

use Test::More;

use strict;
use warnings;

use MooX::Value::ValidationUtils;

my @valid_domains = (
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
    [ 'a.a', 'two label single character label' ],
    [ 'A.A', 'two label single upper character label' ],
    [ '1.1', 'two label single digit label' ],
    [ 'a-b.a-b', 'two labels containing a hyphen' ],
    [ 'a--b.a--b', 'two labels containing consecutive hyphens' ],
    [ 'a2b.a2b', 'two labels containing a digit' ],
    [ '2a.2a',  'two labels starting with a digit' ],
    [ 'a2.a2',  'two labels ending in a digit' ],
    [ '12.12',  'two labels consisting of just digits' ],
    [  'abcdefghijklmnopqrstuvwxyz-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.'
      .'abcdefghijklmnopqrstuvwxyz-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
      'Longest legal label, twice'
    ],
    [ 'a' . ('.a' x 127), 'longest string of single octet labels' ],
    [  'abcdefghijklmnopqrstuvwxyz-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.'
      .'abcdefghijklmnopqrstuvwxyz-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.'
      .'abcdefghijklmnopqrstuvwxyz-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.'
      .'abcdefghijklmnopqrstuvwxyz-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
      'Longest domain from long labels'
    ],
    [ 'a.com.',  'empty root label' ],
);

my @invalid_domains = (
    [ undef,     'undefined' ],
    [ '',        'empty string' ],
    [ '.',       'no labels, just dot' ],
    [ '.com',    'empty first label' ],
    [ 'a..com',  'empty middle label' ],
    [ '-',       'label is just hyphen' ],
    [ '-aa',     'label starts with a hyphen' ],
    [ 'aa-',     'label ends with a hyphen' ],
    [ 'abcdefghijklmnopqrstuvwxyz-ABCDEFGHIJKLMNOPQRSTUVWXYZ-0123456789',
        'label > 63 octets' ],
    [  'abcdefghijklmnopqrstuvwxyz-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.'
      .'abcdefghijklmnopqrstuvwxyz-ABCDEFGHIJKLMNOPQRSTUVWXYZ-0123456789',
        'label (other than first) > 63 octets' ],
    [ 'ab'.('.a' x 127), 'domain name greater than 255 octets' ],
);

plan tests => (@valid_domains+@invalid_domains);

foreach my $t (@valid_domains)
{
    ok( MooX::Value::ValidationUtils::is_valid_domain_name( $t->[0] ),
        "is_valid: $t->[1]"
    );
}

foreach my $t (@invalid_domains)
{
    ok( !MooX::Value::ValidationUtils::is_valid_domain_name( $t->[0] ),
        "!is_valid: $t->[1]"
    );
}
