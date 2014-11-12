#!/usr/bin/env perl

use Test::More tests => 14;
use Test::Exception;

use strict;
use warnings;

use MooX::Value::EmailAddressCommon;

subtest "Doesn't create for invalid domains" => sub {
    throws_ok { MooX::Value::EmailAddressCommon->new(); } qr/^MooX::Value::EmailAddressCommon/, "no create undef domain";
    throws_ok { MooX::Value::EmailAddressCommon->new( '' ); } qr/^MooX::Value::EmailAddressCommon/, "no create empty domain";
};

{
    my $domain = MooX::Value::EmailAddressCommon->new( 'gwadej@cpan.org' );
    isa_ok( $domain, 'MooX::Value::EmailAddressCommon' );
    is( $domain->value, 'gwadej@cpan.org', "EmailAddressCommon matches input" );
    is( $domain->local_part,    'gwadej', "EMailAddress local part matches input" );
    isa_ok( $domain->domain, 'MooX::Value::Domain' );
    is( $domain->domain->value, 'cpan.org', "EMailAddress domain matches input" );
}

{
    throws_ok { MooX::Value::EmailAddressCommon->new( '"gwade@j"@cpan.org' ) }
        qr/^MooX::Value::EmailAddressCommon/;
}

{
    my $domain = MooX::Value::EmailAddressCommon->new( 'gwadej@CPAN.ORG' );
    isa_ok( $domain, 'MooX::Value::EmailAddressCommon' );
    is( $domain->value, 'gwadej@CPAN.ORG', "EmailAddressCommon matches input" );
}

{
    my $domain = MooX::Value::EmailAddressCommon->new_canonical( 'gwadej@cpan.org' );
    isa_ok( $domain, 'MooX::Value::EmailAddressCommon' );
    is( $domain->value, 'gwadej@cpan.org', "EmailAddressCommon matches input" );
}

{
    throws_ok { MooX::Value::EmailAddressCommon->new_canonical( '"g@wadej"@cpan.org' ); }
        qr/^MooX::Value::EmailAddressCommon/;
}

{
    my $domain = MooX::Value::EmailAddressCommon->new_canonical( 'gwadej@CPAN.ORG' );
    isa_ok( $domain, 'MooX::Value::EmailAddressCommon' );
    is( $domain->value, 'gwadej@cpan.org', "EmailAddressCommon canonicalized" );
}

