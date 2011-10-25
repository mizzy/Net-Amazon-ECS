package Net::Amazon::ECS::Request::Keyword;

use strict;
use warnings;
use base qw(Net::Amazon::ECS::Request);

sub new {
    my ( $class, %option ) = @_;
    my $self = $class->SUPER::new(%option);
    bless $self, $class;
}

1;
