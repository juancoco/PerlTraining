package Model::TransactionRegistry;

use strict;
use warnings;

use Utils::Connection;

sub new{
    
    my ( $class, $args ) = @_;
    my $self = {
        sku => $args->{sku} || "",
        sellerCode => $args->{sellerCode} || "",
    };
   
   bless $self, $class;
   return $self;
}

sub getSku {
   my( $self ) = @_;
   return $self->{sku};
}

sub getSellerCode {
   my( $self ) = @_;
   return $self->{sellerCode};
}

sub save{
    my ($self) = @_;

    my $dbh = Utils::Connection->dbconnect();
    my $sth = $dbh->prepare(
        "INSERT INTO transactions (sku, seller_code) values (?,?)"
    );
    
    eval{
        $sth->execute($self->{sku}, $self->{sellerCode});
    };
    if($@){
        die "Error ejecutando sentencia : $@";
    }

    $sth->finish();
    $dbh->disconnect();
}

1;
