package Model::User::Seller;

use strict;
use warnings;

use Model::User;
use Controller::DatabaseController;

our @ISA = qw(Model::User);

sub new {
    my ( $class, $args ) = @_;
    my $local_instance = $class->SUPER::new($args);
    $local_instance->{socialReason} = $args->{socialReason};
    $local_instance->{sellerCode} = $args->{sellerCode};
    
    return $local_instance;
}

sub getSocialReason {
    my( $self ) = @_;
    return $self->{socialReason};
}

sub getSellerCode {
    my( $self ) = @_;
    return $self->{sellerCode};
}

sub save{
    my ($self) = @_;
    $self->SUPER::saveUser($self);
}

1;
