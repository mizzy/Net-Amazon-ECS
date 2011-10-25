package Net::Amazon::ECS::Item::Book;

use strict;
use warnings;
use base qw( Net::Amazon::ECS::Item );
use UNIVERSAL;

__PACKAGE__->mk_accessors( qw/ authors publication_date / );

sub new {
    my ( $class, $item ) = @_;
    my $self = $class->SUPER::new($item);
    bless $self, $class;

    $self->publication_date( $item->{ItemAttributes}->{PublicationDate} );
    my $author = $item->{ItemAttributes}->{Author};
    $author = [ $author ] unless ref $author;
    $self->authors([ @$author ]);

    return $self;
}

sub author {
    my $self = shift;
    return $self->authors->[0];
}

1;
