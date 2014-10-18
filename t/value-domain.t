#!/usr/bin/env perl

use Test::More tests => 9;
use Test::Exception;

use strict;
use warnings;

use MooX::Value::Domain;

subtest "Doesn't create for invalid domains" => sub {
    throws_ok { MooX::Value::Domain->new(); } qr/^MooX::Value::Domain/, "no create undef domain";
    throws_ok { MooX::Value::Domain->new( '' ); } qr/^MooX::Value::Domain/, "no create empty domain";
};

{
    my $domain = MooX::Value::Domain->new( 'google.com' );
    isa_ok( $domain, 'MooX::Value::Domain' );
    is( $domain->value, 'google.com', "Domain matches input" );
}

{
    my $domain = MooX::Value::Domain->new( 'GOOGLE.COM' );
    isa_ok( $domain, 'MooX::Value::Domain' );
    is( $domain->value, 'GOOGLE.COM', "Domain matches input" );
}

{
    my $domain = MooX::Value::Domain->new_canonical( 'google.com' );
    isa_ok( $domain, 'MooX::Value::Domain' );
    is( $domain->value, 'google.com', "Domain matches input" );
}

{
    my $domain = MooX::Value::Domain->new_canonical( 'GOOGLE.COM' );
    isa_ok( $domain, 'MooX::Value::Domain' );
    is( $domain->value, 'google.com', "Domain canonicalized" );
}

