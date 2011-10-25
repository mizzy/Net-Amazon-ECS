#!perl

use strict;
use warnings;
use Test::More qw( no_plan ); # tests => 1;

use Net::Amazon::ECS;
use Net::Amazon::ECS::Request::Keyword;

my %attr;
$attr{access_key_id}     = $ENV{APA_ACCESS_KEY_ID} || '';
$attr{locale}            = $ENV{APA_LOCALE} || 'jp';
$attr{associate_tag}     = $ENV{APA_ASSOCIATE_TAG} || '';
$attr{secret_access_key} = $ENV{APA_SECRET_ACCESS_KEY} || '';

my $ua = Net::Amazon::ECS->new(%attr);

#my $keyword = encode('UTF-8', '楊令伝');

my $req = Net::Amazon::ECS::Request::Keyword->new(
    keywords     => '楊令伝',
    search_index => 'books',
    sort         => 'daterank',
);

my $response = $ua->request($req);

if ( $response->is_error ) {
    warn $response->message;
}

use Data::Dumper;
$Data::Dumper::Indent = 1;

for my $item ( @{ $response->items } ) {
    warn $item->title;
}
