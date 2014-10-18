#!/usr/bin/perl

use Test::More tests => 2;
use Test::Exception;

use strict;
use warnings;

use MooX::Value;

can_ok( 'MooX::Value', 'new', 'value' );
throws_ok { MooX::Value->new() } qr/^MooX::Value/, "Creating the base MooX::Value not allowed";

