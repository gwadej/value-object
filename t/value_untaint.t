#!/usr/bin/env perl -T

use Test::More;
use Test::Exception;

use strict;
use warnings;

eval "use Scalar::Util;";  ## no critic (ProhibitStringyEval)
if($@ || !UNIVERSAL::can( 'Scalar::Util', 'tainted' ))
{
    plan skip_all => 'Ignore taint check without Scalar::Util';
}
else
{
    plan tests => 4;
}

use Value::Object;

{
    package TestValue;
    use parent 'Value::Object';

    sub _is_valid
    {
        my ($self, $value) = @_;

        return $value =~ m/\A.+\z/sm;
    }
}

SKIP: {
    skip "No USER environment variable to test against.", 2 unless $ENV{USER};
    lives_and { ok !Scalar::Util::tainted( TestValue->new( $ENV{USER} )->value ); } 'Value is no longer tainted';
    my $long;
    lives_ok { $long = TestValue->new( "String\nLine2" ) } 'Successfully created.';
    ok !Scalar::Util::tainted( $long->value ), 'Value is no longer tainted';
    is $long->value, "String\nLine2", 'Value is no longer tainted';
}
