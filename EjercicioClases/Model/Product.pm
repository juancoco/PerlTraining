package Model::Product;

use strict;
use warnings;
use Data::Dumper;

use Controller::DatabaseController;


sub new{
   
   my ( $class, $args ) = @_;
   my $self = {
      sku => $args->{sku} || "",
      name => $args->{name} || "",
      sellerCode => $args->{sellerCode} || "",
      isAvailable => $args->{isAvailable} || "",
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

sub hasStock {
    my( $self ) = @_;
    return $self->{isAvailable};
}

sub updateStock {
   my ( $self, $status ) = @_;
   $self->{ isAvailable } = $status;
   return $self->{isAvailable};
}

sub getProductBySku{
    my ( $class, $sku ) = @_;
    return Controller::DatabaseController->retrieveProductBySku($sku);
}

sub getProducts{
    my ( $class, $sku ) = @_;
    return Controller::DatabaseController->retrieveProducts($sku);
}

sub save{
    my ($class, $product) = @_;
    Controller::DatabaseController->save('products', $product);
}

1;
