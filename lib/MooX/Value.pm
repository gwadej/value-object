package MooX::Value;

use warnings;
use strict;

use Moo;
use namespace::clean;

our $VERSION = '0.02';

has value => ( is => 'ro' );

sub BUILDARGS
{
    my ($class, $value) = @_;
    return { 'value' => $value };
}

sub BUILD
{
    my ($self) = @_;
    my ($why, $long, $data) = $self->_why_invalid( $self->{value} );
    _throw_exception( $why, $long, $data ) if defined $why;
    return $self;
}

# A subclass must override this method or _is_invalid to be able to create value objects.
sub _why_invalid
{
    my ($self, $value) = @_;
    return ( ref($self) . ": Invalid parameter when creating value object.", "", undef )
        unless $self->_is_valid( $value );
    return;
}

# A subclass must override this method or _why_invalid to be able to create value objects.
sub _is_valid
{
    my ($self, $value) = @_;
    return;
}

# Default exception support just uses die to throw an exception.
sub _throw_exception
{
    my ($why, $longmsg, $data) = @_;
    die $why;
}

1;
__END__

=head1 NAME

MooX::Value - Base class for minimal Value Object classes

=head1 VERSION

This document describes MooX::Value version 0.02

=head1 SYNOPSIS

    package MooX::Value::Identifier;

    use Moo;
    use namespace::clean;

    extends 'MooX::Value';

    sub _is_valid
    {
        my ($self, $value) = @_;
        return $value =~ m/\A[a-zA-Z_][a-zA-Z0-9_]*\z/;
    }


=head1 DESCRIPTION

This class serves as a base class for classes implementing the I<Value Object>
pattern. The core principles of a Value Object class are:

=over 4

=item The meaning of the object is solely its value.

=item The value of the object is immutable.

=item The object is validated on creation.

=back

Every C<MooX::Value>-derived object has a minimum of a C<value> method that
returns its value.  There is no mutator methods that allow for changing the
value of the object. If you need an object with a new value, create a new
object. The concept is that one of these objects is more like the integer B<5>,
than the variable C<$v> that contains the value. You cannot modify the value of
B<5>, but you can make a new integer that is the value of B<5> changed by some
amount.

The core of this particular Value Object implementation is the validation on
creation. Every subclass of C<MooX::Value> must override either the
C<_is_valid> or the C<_why_invalid> method. The C<_is_valid> method determines
the validity of the supplied value. If the supplied value is not valid,
C<_is_valid> returns false and the constructor throws an exception. If you
prefer to have control over the message of the exception, you can override
C<_why_invalid> which returns C<undef> for a valid value and information about
why the value is not valid otherwise. The result is that any C<MooX::Value>
object is guaranteed to be validated by its constructor.

There is a temptation when designing a Value object to include extra
functionality into the class. The C<MooX::Value> class instead aims for the
minimal function consistent with the requirements listed above. If a subclass
needs more functionality it can be added to that subclass at the point of need.
Valid extra functionality might be accessors for part of the value if it is
made of smaller pieces. Any mutator methods would violate the fundamental
design of the C<MooX::Value> base class and are, therefore, discouraged.

=head1 INTERFACE

The class definition is currently very new. There is a potential that the
interface may change in the near-term. In particular, the L<Subclassing
Interface> has a potential for some modification to make it more flexible.

=head2 Public Interface

The public interface only supports creation of the object and returning the
value of the object.

=head3 $class->new( $value )

The new method is a constructor taking a single value. If the value is deemed
valid by the C<_why_invalid> internal method (which defaults to checking the
internal C<_is_valid> method if not overridden), an object is returned.
Otherwise an exception is thrown.

=head3 $obj->value()

Return a copy of the value of the C<MooX::Value>-derived object. This method
should not return modifiable internal state.

=head2 Subclassing Interface

The following methods may be overridden by any subclass to provide actual
validation and reporting of errors.

=head3 $self->_is_valid()

This method B<must> be overridden in any subclass (unless you override
C<_why_invalid> instead).

It performs the validation on the supplied value and returns C<true> if the
parameter is valid and C<false> otherwise.

=head3 $self->_why_invalid()

By default, this method calls the C<_is_invalid> method and returns c<undef> on
success or a list of three values on failure. The default error message is
generic, but it makes creating subclasses by just overriding C<_is_valid> easier.

By overriding this method instead of C<_is_valid> you gain control over the
error message reported in the exception. If the supplied value is not valid,
C<_why_invalid> returns a list of three values:

=over 4

=item $why

This is the only required return item. It is a short message thrown as the
exception describing how the value is not valid.

=item $longmsg

This optional return item is intended to provide a more detailed error message
than C<$why>. With the default exception method, this message is not used.

=item $data

This optional return item is intended to provide data from the invalidation that
could be used for higher level reporting. This data is not used by the default
exception method.

=back

=head3 $self->_throw_exception( $why, $longmsg, $data )

This internal method handles the actual throwing of the exception. If you need
to use something more advanced than a simple C<die>, you can override this
method. The C<_throw_exception> method B<must> throw an exception by some
means. It should never return.

=head2 Internal Interface

These methods are documented for completeness, but are called internally and
do not require any modification.

=head3 BUILDARGS

Internal function that makes the simple constructor compatible with the C<Moo>
constructor interface.

=head3 BUILD

Internal function that validates the constructor input.

=head1 DIAGNOSTICS

=over 4

=item C<< %s: Invalid parameter when creating value object. >>

The supplied parameter is not valid for the Value class.

=back

=head1 CONFIGURATION AND ENVIRONMENT

C<MooX::Value> requires no configuration files or environment variables.

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
