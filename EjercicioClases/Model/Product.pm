package Model::Product;

use strict;
use warnings;

use Utils::Connection;


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

sub getName {
    my( $self ) = @_;
    return $self->{name};
}

sub getSellerCode {
    my( $self ) = @_;
    return $self->{sellerCode};
}

sub getStock {
    my( $self ) = @_;
    return $self->{isAvailable};
}

sub hasStock {
    my( $self ) = @_;
    return $self->{isAvailable};
}

sub updateStock {
   my ( $self, $status, $sku ) = @_;
   $self->{ isAvailable } = $status;

   my $dbh = Utils::Connection->dbconnect();
   my $sth = $dbh->prepare(
       "UPDATE product SET stock = ? WHERE sku = ?"
   );
   eval{
       $sth->execute($status, $sku) or die $DBI::errstr;
   };
   if($@){
       die "Error ejecutando sentencia : $@";
   }
   $sth->finish();
   $dbh->disconnect();
   return $self->{isAvailable};
}

sub getProductBySku{
    my ( $class, $sku ) = @_;

    my $dbh = Utils::Connection->dbconnect();
    my $sth = $dbh->prepare(
        "SELECT sku, name, seller_code, stock FROM product WHERE sku = ? LIMIT 1"
    );

    eval{
        $sth->execute($sku) or die $DBI::errstr;
    };
    if($@){
        die "Error ejecutando sentencia : $@";
    }

    my @row = $sth->fetchrow_array();
    my ($rsku, $rname, $rseller, $rstock) = @row;
    my %product_attrs = (
        sku => $rsku,
        name => $rname,
        sellerCode => $rseller,
        isAvailable => $rstock,
    );
    $sth->finish();
    $dbh->disconnect();
    return Model::Product->new(\%product_attrs);
}

sub getProducts{
    my ($class) = @_;

    my $dbh = Utils::Connection->dbconnect();
    my $sth = $dbh->prepare(
        "SELECT sku, name, seller_code, stock FROM product"
    );

    eval{
        $sth->execute() or die $DBI::errstr;
    };
    if($@){
        die "Error ejecutando sentencia : $@";
    }

    my @products;
    
    while (my @row = $sth->fetchrow_array()) {
        my ($sku, $name, $seller, $stock) = @row;
        my %product_attrs = (
            sku => $sku,
            name => $name,
            sellerCode => $seller,
            isAvailable => $stock,
        );
        push(@products, Model::Product->new(\%product_attrs));
    }
    $sth->finish();
    $dbh->disconnect();
    return @products;
}

sub save{
    my ($self) = @_;

    my $dbh = Utils::Connection->dbconnect();
    my $sth = $dbh->prepare(
        "INSERT INTO product (sku, name, seller_code, stock) values (?,?,?,?)"
    );
    eval{
        $sth->execute($self->{sku}, $self->{name}, $self->{sellerCode}, $self->{isAvailable}) or die $DBI::errstr;
    };
    if($@){
        die "Error ejecutando sentencia : $@";
    }
    $sth->finish();
    $dbh->disconnect();
}

1;
