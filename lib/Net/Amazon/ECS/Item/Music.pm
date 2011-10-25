package Net::Amazon::ECS::Item::Music;

use strict;
use warnings;
use base qw( Net::Amazon::ECS::Item );

__PACKAGE__->mk_accessors( qw/ artists release_date / );

sub new {
    my ( $class, $item ) = @_;
    my $self = $class->SUPER::new($item);
    bless $self, $class;

    $self->release_date( $item->{ItemAttributes}->{ReleaseDate} );
    my $artist = $item->{ItemAttributes}->{Artist};
    $artist = [ $artist ] unless ref $artist;
    $self->artists([ @$artist ]);
    return $self;
}

sub artist {
    my $self = shift;
    return $self->artists->[0];
}

1;
