use strict;
use warnings;
use Test::More tests => 6;

BEGIN {
    use_ok( 'Value::Object' );
    use_ok( 'Value::Object::DomainLabel' );
    use_ok( 'Value::Object::Domain' );
    use_ok( 'Value::Object::EmailAddressCommon' );
    use_ok( 'Value::Object::EmailAddress' );
    use_ok( 'Value::Object::Identifier' );
}

note( "Testing Value::Object $Value::Object::VERSION" );
