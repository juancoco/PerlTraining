package Model::User::Seller;

use strict;
use warnings;
use Data::Dumper;

use Model::User;
use Controller::DatabaseController;

our @ISA = qw(Model::User);

sub new {
    my ( $class, $args ) = @_;
    $args->{socialReason} = "";
    $args->{sellerCode} = "";
    my $local_instance = $class->SUPER::new($args);
    return $local_instance;
}

sub getSellerCode {
    my( $self ) = @_;
    return $self->{sellerCode};
}

sub save{
    my ($self) = @_;
    Controller::DatabaseController->save('sellers', $self);
}

1;
