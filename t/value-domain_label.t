#!/usr/bin/env perl

use Test::More tests => 9;
use Test::Exception;

use strict;
use warnings;

use MooX::Value::DomainLabel;

subtest "Doesn't create for invalid domains" => sub {
    throws_ok { MooX::Value::DomainLabel->new(); } qr/^MooX::Value::DomainLabel/, "no create undef domain label";
    throws_ok { MooX::Value::DomainLabel->new( '' ); } qr/^MooX::Value::DomainLabel/, "no create empty domain label";
    throws_ok { MooX::Value::DomainLabel->new( 'google.com' ); } qr/^MooX::Value::DomainLabel/, "no create empty domain label";
};

{
    my $domain = MooX::Value::DomainLabel->new( 'google' );
    isa_ok( $domain, 'MooX::Value::DomainLabel' );
    is( $domain->value, 'google', "DomainLabel matches input" );
}

{
    my $domain = MooX::Value::DomainLabel->new( 'GOOGLE' );
    isa_ok( $domain, 'MooX::Value::DomainLabel' );
    is( $domain->value, 'GOOGLE', "DomainLabel matches input" );
}

{
    my $domain = MooX::Value::DomainLabel->new_canonical( 'google' );
    isa_ok( $domain, 'MooX::Value::DomainLabel' );
    is( $domain->value, 'google', "DomainLabel matches input" );
}

{
    my $domain = MooX::Value::DomainLabel->new_canonical( 'GOOGLE' );
    isa_ok( $domain, 'MooX::Value::DomainLabel' );
    is( $domain->value, 'google', "DomainLabel canonicalized" );
}

