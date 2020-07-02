package Model::User::Seller;

use strict;
use warnings;
use Data::Dumper;

use Model::User;
use Controller::DatabaseController;

our @ISA = qw(Model::User);

sub new {
    my ($class) = @_;
    
    my $self = $class->SUPER::new( $_[1], $_[2], $_[3] );
    $self->{socialReason}   = $_[4];
    $self->{sellerCode} = $_[5];
    bless $self, $class;
    return $self;
}

sub getSellerCode {
    my( $self ) = @_;
    return $self->{sellerCode};
}

sub save{
    my ($self, $seller) = @_;
    Controller::DatabaseController->save('sellers', $seller);
    #Controller::DatabaseController->saveSeller($seller);
}

1;
