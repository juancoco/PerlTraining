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

   my $dbConnectionString="DBI:mysql:database=PERL_STORE;host=172.17.0.2;mysql_local_infile1";
   my $dbLogin="root";
   my $dbPassword="1234";
   my $dbh;
   eval{
      $dbh = DBI->connect($dbConnectionString, $dbLogin, $dbPassword);
    };
    if($@){
      print "Error conectando a db : $@"
    }
   my $sth = $dbh->prepare(
       "UPDATE product SET stock = ? WHERE sku = ?"
   );
   $sth->execute($status, $sku) or die $DBI::errstr;
   $sth->finish();
   $dbh->disconnect();
   return $self->{isAvailable};
}

sub getProductBySku{
    my ( $class, $sku ) = @_;

    my $dbConnectionString="DBI:mysql:database=PERL_STORE;host=172.17.0.2;mysql_local_infile1";
    my $dbLogin="root";
    my $dbPassword="1234";
    my $dbh;
    eval{
      $dbh = DBI->connect($dbConnectionString, $dbLogin, $dbPassword);
    };
    if($@){
      print "Error conectando a db : $@"
    }

    my $sth = $dbh->prepare(
        "SELECT sku, name, seller_code, stock FROM product WHERE sku = ?"
    );

    eval{
        $sth->execute($sku) or die $DBI::errstr;
    };
    if($@){
        print "Error ejecutando sentencia : $@"
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

    my $dbConnectionString="DBI:mysql:database=PERL_STORE;host=172.17.0.2;mysql_local_infile1";
    my $dbLogin="root";
    my $dbPassword="1234";
    my $dbh;
    eval{
      $dbh = DBI->connect($dbConnectionString, $dbLogin, $dbPassword);
    };
    if($@){
      print "Error conectando a db : $@"
    }

    my $sth = $dbh->prepare(
        "SELECT sku, name, seller_code, stock FROM product"
    );

    eval{
        $sth->execute() or die $DBI::errstr;
    };
    if($@){
        print "Error ejecutando sentencia : $@"
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
    my ($class, $product) = @_;

    my $dbConnectionString="DBI:mysql:database=PERL_STORE;host=172.17.0.2;mysql_local_infile1";
    my $dbLogin="root";
    my $dbPassword="1234";
    my $dbh;
    eval{
      $dbh = DBI->connect($dbConnectionString, $dbLogin, $dbPassword);
    };
    if($@){
      print "Error conectando a db : $@"
    }

    my $sth = $dbh->prepare(
        "INSERT INTO product (sku, name, seller_code, stock) values (?,?,?,?)"
    );
    eval{
        $sth->execute($product->getSku, $product->getName, $product->getSellerCode, $product->getStock) or die $DBI::errstr;
    };
    if($@){
        print "Error ejecutando sentencia : $@"
    }
   
    $sth->finish();
    $dbh->disconnect();
}

1;
