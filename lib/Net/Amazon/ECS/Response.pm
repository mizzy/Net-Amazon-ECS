package Net::Amazon::ECS::Response;

use strict;
use warnings;
use base qw(Class::Accessor::Fast);
use XML::Simple;
use UNIVERSAL::require;

__PACKAGE__->mk_accessors( qw/ is_success is_error message items / );

sub new {
    my ( $class, $response ) = @_;

    my $self = {
        items => [],
    };

    bless $self, $class;

    $self->_parse_xml($response->content);

    return $self;
}

sub _parse_xml {
    my ( $self, $xml ) = @_;

    $xml = XMLin($xml);

    if ( my $errors = $xml->{Items}->{Request}->{Errors}->{Error} ) {

        $errors = [ $errors ] if ref $errors ne 'ARRAY';
        $self->is_success(0);
        $self->is_error(1);

        for ( @$errors ) {
            $self->message( join "\n", ( $self->message, $_->{Message} ) );
        }

        return;
    }

    if ( my $message = $xml->{Items}->{Request}->{Errors}->{Error}->{Message} ) {

        $self->message($message);
        return;
    }

    for my $item ( @{ $xml->{Items}->{Item} } ) {
        my $class = 'Net::Amazon::ECS::Item::' . $item->{ItemAttributes}->{ProductGroup};
        $class->require;
        push @{$self->items}, $class->new($item);
    }
}





1;
