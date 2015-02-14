#!/usr/bin/env perl

use Test::More tests => 9;
use Test::Exception;

use strict;
use warnings;

use Value::Domain;

subtest "Doesn't create for invalid domains" => sub {
    throws_ok { Value::Domain->new(); } qr/^Value::Domain/, "no create undef domain";
    throws_ok { Value::Domain->new( '' ); } qr/^Value::Domain/, "no create empty domain";
};

{
    my $domain = Value::Domain->new( 'google.com' );
    isa_ok( $domain, 'Value::Domain' );
    is( $domain->value, 'google.com', "Domain matches input" );
}

{
    my $domain = Value::Domain->new( 'GOOGLE.COM' );
    isa_ok( $domain, 'Value::Domain' );
    is( $domain->value, 'GOOGLE.COM', "Domain matches input" );
}

{
    my $domain = Value::Domain->new_canonical( 'google.com' );
    isa_ok( $domain, 'Value::Domain' );
    is( $domain->value, 'google.com', "Domain matches input" );
}

{
    my $domain = Value::Domain->new_canonical( 'GOOGLE.COM' );
    isa_ok( $domain, 'Value::Domain' );
    is( $domain->value, 'google.com', "Domain canonicalized" );
}

