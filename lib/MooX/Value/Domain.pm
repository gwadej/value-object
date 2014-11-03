package MooX::Value::Domain;

use warnings;
use strict;
use Moo;
use namespace::clean;

use MooX::Value::ValidationUtils;

our $VERSION = '0.01';

extends 'MooX::Value';

sub _why_invalid
{
    my ($self, $value) = @_;
    my ($why, $long, $data) = MooX::Value::ValidationUtils::why_invalid_domain_name( $value );
    return ( __PACKAGE__ . ": $why", $long, $data ) if defined $why;
    return;
}

sub new_canonical
{
    my ($class, $value) = @_;
    $value =~ tr/A-Z/a-z/;
    return $class->new( $value );
}

sub make_subdomain
{
    my ($self, $label) = @_;
    die __PACKAGE__ . ': undefined label' unless defined $label;
    die __PACKAGE__ .': Not a DomainLabel' unless eval { $label->isa( 'MooX::Value::DomainLabel' ); };
    return __PACKAGE__->new( $label->value . '.' . $self->value );
}

1;
__END__

=head1 NAME

MooX::Value::Domain - Value object class representing Internet domain names


=head1 VERSION

This document describes MooX::Value::Domain version 0.01


=head1 SYNOPSIS

    use MooX::Value::Domain;

    my $mcpan = MooX::Value::Domain->new( 'metacpan.org' );
    my $goog  = MooX::Value::Domain->new( 'google.com' );

    my $domain = MooX::Value::Domain->new( $unsafe_domain_name );
    # We'll only get here if the $unsafe_domain_name was a legal domain name

    print "'", $domain->value, "' is a valid domain name.\n";

=head1 DESCRIPTION

A C<MooX::Value::Domain> value object represents an Internet domain name as
defined in RFCs 1123 and 2181. A fully qualified domain name cannot be more than
255 characters in length and must be made up of labels separated by the '.'
character. Each label can be no more than 63 characters in length and is made
up of characters from a limited character set.

The domain name specification allows for a trailing dot.

If these criteria are not met, an exception is thrown.

=head1 INTERFACE

=head2 MooX::Value::Domain->new( $domstr )

Create a new domain name object if the supplied string is a valid domain name.
Otherwise throw an exception.

=head2 MooX::Value::Domain->new_canonical( $domstr )

Create a new domain name object if the supplied string is a valid domain name.
Otherwise throw an exception.

Unlike the C<new> method, the ASCII characters of the supplied C<$domstr> are
lowercased before the domain is created. The canonical version of the domain
name is always lowercase.

=head2 $dom->value()

Returns a string that represents the domain name of the object.

=head2 $dom->make_subdomain( $label )

Create a new C<MooX::Value::Domain> object that is created when the supplied label
is used as a subdomain of the domain represented by C<$dom>.

=head1 CONFIGURATION AND ENVIRONMENT

C<MooX::Value::Domain> requires no configuration files or environment variables.

=head1 DEPENDENCIES

L<Moo>, L<namespace::clean>

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

