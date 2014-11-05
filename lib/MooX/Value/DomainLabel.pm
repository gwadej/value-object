package MooX::Value::DomainLabel;

use warnings;
use strict;
use Moo;
use namespace::clean;

use MooX::Value::ValidationUtils;

our $VERSION = '0.02';

extends 'MooX::Value';

sub _why_invalid
{
    my ($self, $value) = @_;
    my ($why, $long, $data) = MooX::Value::ValidationUtils::why_invalid_domain_label( $value );
    return ( __PACKAGE__ . ": $why", $long, $data ) if defined $why;
    return;
}

sub new_canonical
{
    my ($class, $value) = @_;
    $value =~ tr/A-Z/a-z/;
    return $class->new( $value );
}

1;
__END__

=head1 NAME

MooX::Value::DomainLabel - Value object representing 1 label of an Internet domain

=head1 VERSION

This document describes MooX::Value::DomainLabel version 0.02

=head1 SYNOPSIS

    use MooX::Value::DomainLabel;

    my $com_label  = MooX::Value::DomainLabel->new( 'com' );
    my $goog_label = MooX::Value::DomainLabel->new( 'google' );

=head1 DESCRIPTION

When working with Internet domains, it is sometimes useful to be able to
validate one segment (or label) of the domain. The C<MooX::Value::DomainLabel>
provides that validation. The domain label specification is provided by the
RFCs 1123 and 2181. A label must be between 1 and 63 ASCII characters in
length. Only certain characters are allowed in the domain name label.

Trying to create a label that does not meet these criteria results in a thrown
exception.

=head1 INTERFACE

=head2 MooX::Value::DomainLabel->new( $label )

Create a value object if the supplied C<$label> validates according to RFCs 1123 and
2181. Otherwise throw an exception.

=head2 MooX::Value::DomainLabel->new_canonical( $label )

Create a value object if the supplied C<$label> validates according to RFCs 1123 and
2181. Otherwise throw an exception.

Unlike the C<new> method, the ASCII characters of the supplied C<$label> are
lowercased before the domain label is created. The canonical version of the
domain label is always lowercase.

=head2 $dl->value()

Return a string matching the value of the Value object.

=head1 CONFIGURATION AND ENVIRONMENT

C<MooX::Value::DomainLabel> requires no configuration files or environment variables.

=head1 DEPENDENCIES

None.

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-moox-value@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.

=head1 AUTHOR

G. Wade Johnson  C<< gwadej@cpan.org >>

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2014, G. Wade Johnson C<< gwadej@cpan.org >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.

