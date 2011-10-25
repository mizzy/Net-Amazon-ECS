package Net::Amazon::ECS::Request;

use strict;
use warnings;
use Carp;

our %default = (
    operation      => 'item_search',
    response_group => 'large',
    content_type   => 'xml',
    search_index   => 'books',
);

our %ecs_url = (
    jp => 'http://webservices.amazon.co.jp/onca/xml',
);

sub new {
    my ( $class, %option ) = @_;

    my $self = {
        %default,
        %option,
    };

    bless $self, $class;
}

sub params {
    my $self = shift;
    return wantarray ? %$self : { %$self };
}

sub response_class {
    my $self = shift;

    my $response_class = ref $self;
    $response_class =~ s/Request/Response/;
    return $response_class;
}

sub ecs_url {
    my ( $self, $locale ) = @_;
    return $ecs_url{$locale};
}

1;
