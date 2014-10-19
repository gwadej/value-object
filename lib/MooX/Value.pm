package MooX::Value;

use warnings;
use strict;

use Moo;
use namespace::clean;

our $VERSION = '0.01';

has value => ( is => 'ro' );

sub BUILDARGS
{
    my ($class, $value) = @_;
    return { 'value' => $value };
}

sub BUILD
{
    my ($self) = @_;
    $self->_ensure_valid();
    return $self;
}

sub _ensure_valid
{
    my ($self) = @_;
    die ref($self) . ": Invalid parameter" unless $self->_is_valid( $self->{value} );
    return;
}

# A subclass must override this method to be able to create value objects.
sub _is_valid
{
    my ($self, $value) = @_;
    return;
}

1;
__END__

=head1 NAME

MooX::Value - Base class for minimal Value Object classes

=head1 VERSION

This document describes MooX::Value version 0.01

=head1 SYNOPSIS

    package MooX::Value::Identifier;

    use Moo;
    use namespace::clean;

    extends 'MooX::Value';

    sub _is_valid
    {
        my ($self, $value) = @_;
        return $value =~ m/\A[a-zA-Z_]\w*\z/;
    }


=head1 DESCRIPTION

This class serves as a base class for classes implementing the Value Object
pattern. The core principles of a Value Object class are:

=over 4

=item The meaning of the object is solely its value.

=item The value of the object is immutable.

=item The object is validated on creation.

=back

Every Value object has a minimum of a C<value> method that returns its value.
There is no mutator methods that allow for changing the value of the object. If
you need an object with a new value, create one.

The core of this particular Value Object implementation is the validation on
creation.  Every subclass of C<MooX::Value> must override the C<_is_valid>
method. This method is what determines the validity of the supplied value. If
the supplied value is not valid, an exception is thrown. The result is that any
Value object is guaranteed to be validated by its constructor.

There is a temptation when designing a Value object to include extra
functionality into the class. The C<MooX::Value> class instead aims for the
minimal function consistent with the requirements listed above. If a subclass
needs more functionality it can be added at the point of need.

=head1 INTERFACE

=head2 Public Interface

=head3 $class->new( $value )

The new method is a constructor taking a single value. If the value is deemed
valid by the C<_is_valid> internal method, an object is returned. Otherwise an
exception is thrown.

=head3 $obj->value()

Return a copy of the value of the C<MooX::Value>-derived object. This method
should not return modifiable internal state.

=head2 Subclassing Interface

=head3 $self->_is_valid()

This method B<must> be overridden in any subclass. It performs the validation
on the supplied value and returns C<true> if the parameter is valid and
C<false> otherwise.

=head3 $self->_ensure_valid()

This method calls the C<_is_valid> method and throws an exception on failure.
It may be overridden to provide more useful exceptions.

=head2 Internal Interface

=head3 BUILDARGS

Internal function that makes the simple constructor compatible with the C<Moo>
constructor interface.

=head3 BUILD

Internal function that validates the constructor input.

=head1 DIAGNOSTICS

=item C<< %s: Invalid parameter >>

The supplied parameter is not valid for the Value class.

=back

=head1 CONFIGURATION AND ENVIRONMENT

MooX::Value requires no configuration files or environment variables.

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

G. Wade Johnson  C<< <gwadej@cpan.org> >>

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2014, G. Wade Johnson C<< <gwadej@cpan.org> >>. All rights reserved.

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
