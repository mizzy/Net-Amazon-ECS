package Net::Amazon::ECS::Item;

use strict;
use warnings;
use base qw( Class::Accessor::Fast );

__PACKAGE__->mk_accessors( qw/ title small_image_url url editorial_reviews / );

sub new {
    my ( $class, $item ) = @_;
    my $self = {
        item              => $item,
        editorial_reviews => [],
    };

    bless $self, $class;

    $self->title( $item->{ItemAttributes}->{Title} );
    $self->small_image_url( $item->{SmallImage}->{URL} );
    $self->url( $item->{DetailPageURL} );

    my $editorial_reviews = $item->{EditorialReviews}->{EditorialReview};
    $editorial_reviews = [ $editorial_reviews ]
        if $editorial_reviews and ref $editorial_reviews ne 'ARRAY';

    for ( @$editorial_reviews ) {
        push @{ $self->editorial_reviews }, {
            source  => $_->{Source},
            content => $_->{Content},
        };
    }

    return $self;
}

sub editorial_review {
    my $self = shift;
    return @{ $self->editorial_reviews }
        ? $self->editorial_reviews->[0] : { source => '', content => '' };
}

1;
