package Model::Product;

use strict;
use warnings;
use Data::Dumper;


sub new{
    my $class = shift;
    my $self = {
        sku => shift,
        name => shift,
        sellerCode => shift,
        isAvailable => shift,
    };
    
    bless $self, $class;
    return $self;
}

sub getProductDetail {
   my( $self ) = @_;
   my $productDetail = $self->{sku} . " - " . $self->{name} . " - " . $self->{sellerCode};
   return $productDetail;
}

sub getSku {
    my( $self ) = @_;
    return $self->{sku};
}

sub getStatus {
    my( $self ) = @_;
    return $self->{isAvailable};
}

sub setStatus {
   my ( $self, $status ) = @_;
   $self->{ isAvailable } = $status if defined($status);
   return $self->{isAvailable};
}

1;
