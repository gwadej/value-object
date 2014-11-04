#!/usr/bin/env perl

use Test::More tests => 19;
use Test::Exception;

use strict;
use warnings;

use MooX::Value::EmailAddress;

subtest "Doesn't create for invalid domains" => sub {
    throws_ok { MooX::Value::EmailAddress->new(); } qr/^MooX::Value::EmailAddress/, "no create undef domain";
    throws_ok { MooX::Value::EmailAddress->new( '' ); } qr/^MooX::Value::EmailAddress/, "no create empty domain";
};

{
    my $domain = MooX::Value::EmailAddress->new( 'gwadej@cpan.org' );
    isa_ok( $domain, 'MooX::Value::EmailAddress' );
    is( $domain->value, 'gwadej@cpan.org', "EmailAddress matches input" );
    is( $domain->local_part,    'gwadej', "EMailAddress local part matches input" );
    isa_ok( $domain->domain, 'MooX::Value::Domain' );
    is( $domain->domain->value, 'cpan.org', "EMailAddress domain matches input" );
}

{
    my $domain = MooX::Value::EmailAddress->new( '"gwade@j"@cpan.org' );
    isa_ok( $domain, 'MooX::Value::EmailAddress' );
    is( $domain->value, '"gwade@j"@cpan.org', "EmailAddress matches input" );
    is( $domain->local_part,    '"gwade@j"', "EMailAddress local part matches input" );
    isa_ok( $domain->domain, 'MooX::Value::Domain' );
    is( $domain->domain->value, 'cpan.org', "EMailAddress domain matches input" );
}

{
    my $domain = MooX::Value::EmailAddress->new( 'gwadej@CPAN.ORG' );
    isa_ok( $domain, 'MooX::Value::EmailAddress' );
    is( $domain->value, 'gwadej@CPAN.ORG', "EmailAddress matches input" );
}

{
    my $domain = MooX::Value::EmailAddress->new_canonical( 'gwadej@cpan.org' );
    isa_ok( $domain, 'MooX::Value::EmailAddress' );
    is( $domain->value, 'gwadej@cpan.org', "EmailAddress matches input" );
}

{
    my $domain = MooX::Value::EmailAddress->new_canonical( '"g@wadej"@cpan.org' );
    isa_ok( $domain, 'MooX::Value::EmailAddress' );
    is( $domain->value, '"g@wadej"@cpan.org', "EmailAddress matches input" );
}

{
    my $domain = MooX::Value::EmailAddress->new_canonical( 'gwadej@CPAN.ORG' );
    isa_ok( $domain, 'MooX::Value::EmailAddress' );
    is( $domain->value, 'gwadej@cpan.org', "EmailAddress canonicalized" );
}

