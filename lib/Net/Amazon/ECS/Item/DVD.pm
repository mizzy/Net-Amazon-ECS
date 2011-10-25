package Net::Amazon::ECS::Item::DVD;

use strict;
use warnings;
use base qw( Net::Amazon::ECS::Item );

__PACKAGE__->mk_accessors( qw/ release_date / );

sub new {
    my ( $class, $item ) = @_;
    my $self = $class->SUPER::new($item);
    bless $self, $class;

    $self->release_date( $item->{ItemAttributes}->{ReleaseDate} );

    return $self;
}


1;
