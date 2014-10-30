package MooX::Value::EmailAddress;

use warnings;
use strict;
use Moo;
use namespace::clean;

use MooX::Value::ValidationUtils;
use MooX::Value::Domain;

our $VERSION = '0.01';

extends 'MooX::Value';

sub _is_valid
{
    my ($self, $value) = @_;
    die __PACKAGE__ . ': undefined value' unless defined $value;
    die __PACKAGE__ . ': missing domain'  unless $value =~ tr/@//;
    my ($lp, $dom) = split /@/, $value, 2;
    return MooX::Value::ValidationUtils::is_valid_email_local_part( $lp )
        && MooX::Value::ValidationUtils::is_valid_domain_name( $dom );
}

sub local_part
{
    my ($self) = @_;
    return substr( $self->value, 0, index( $self->value, '@' ) );
}

sub domain
{
    my ($self) = @_;
    return MooX::Value::Domain->new( substr( $self->value, index( $self->value, '@' )+1 ) );
}

sub new_canonical
{
    my ($class, $value) = @_;
    die __PACKAGE__ . ': undefined value' unless defined $value;
    die __PACKAGE__ . ': missing domain'  unless $value =~ tr/@//;
    my ($lp, $dom) = split /@/, $value, 2;
    $dom =~ tr/A-Z/a-z/;
    return __PACKAGE__->new( "$lp\@$dom" );
}

1;
__END__

=head1 NAME

MooX::Value::EmailAddress - A value object representing a valid email address.

=head1 VERSION

This document describes MooX::Value::EmailAddress version 0.01

=head1 SYNOPSIS

    use MooX::Value::EmailAddress;

    my $email = MooX::Value::EmailAddress->new( 'webmaster@example.com' );
    my $me    = MooX::Value::EmailAddress->new( 'gwadej@cpan.org' );

=head1 DESCRIPTION

A C<MooX::Value::EmailAddress> value object represents a validate email address.
That email address may not represent an address that can actually receive an
email, but the form of the address is at least valid.

The specification of the email address is given by RFC 5322 and supports both
the quoted and dotted forms.

=head1 INTERFACE

=head2 MooX::Value::EmailAddress->new( $emailstr )

Create a value object if the supplied C<$emailstr> validates according to RFC 5322.
Otherwise throw an exception.

=head2 MooX::Value::EmailAddress->new_canonical( $emailstr )

Create a value object if the supplied C<$emailstr> validates according to RFC 5322.
Otherwise throw an exception.

Unlike the C<new> method, the ASCII characters of the domain portion of the
supplied C<$emailstr> are lowercased before the email address is created. The
canonical version of the domain is always lowercase.

=head2 $email->value()

Return a string matching the full email address of the Value object.

=head2 $email->local_part()

Return a string matching the local part of the Value object.

=head2 $email->domain()

Return a C<MooX::Value::Domain> object representing the domain portion of the
Value object.

=head1 CONFIGURATION AND ENVIRONMENT

C<MooX::Value::EmailAddress> requires no configuration files or environment variables.

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

