use strict;
use warnings;
use Test::More tests => 10;

BEGIN {
    use_ok( 'Value::Object' );
    use_ok( 'Value::Object::DomainLabel' );
    use_ok( 'Value::Object::Domain' );
    use_ok( 'Value::Object::EmailAddressCommon' );
    use_ok( 'Value::Object::EmailAddress' );
    use_ok( 'Value::Object::Identifier' );
    use_ok( 'Value::Object::HexString' );
    use_ok( 'Value::Object::W3CDate' );
    use_ok( 'Value::Object::W3CDateTime' );
    use_ok( 'Value::Object::W3CDateTimeZ' );
}

note( "Testing Value::Object $Value::Object::VERSION" );
