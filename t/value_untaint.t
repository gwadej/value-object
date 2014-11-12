#!/usr/bin/env perl -T

use Test::More;
use Test::Exception;

use strict;
use warnings;

eval "use Scalar::Util;";  ## no critic (ProhibitStringyEval)
if($@)
{
    plan skip_all => 'Ignore taint check without Scalar::Util';
}
else
{
    plan tests => 1;
}

use MooX::Value;

{
    package TestValue;
    use Moo;
    extends 'MooX::Value';

    sub _is_valid
    {
        my ($self, $value) = @_;

        return $value =~ m/\A\S+\z/;
    }
}

SKIP: {
    skip "No USER environment variable to test against.", 1 unless $ENV{USER};
    lives_and { ok !Scalar::Util::tainted( TestValue->new( $ENV{USER} )->value ); } 'Value is no longer tainted';
}
