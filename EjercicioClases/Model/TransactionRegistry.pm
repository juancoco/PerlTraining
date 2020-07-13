package Model::TransactionRegistry;

use strict;
use warnings;
use Data::Dumper;

use Controller::DatabaseController;

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
    my ($class, $transaction) = @_;

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
        "INSERT INTO transactions (sku, seller_code) values (?,?)"
    );
    
    eval{
        $sth->execute($transaction->getSku, $transaction->getSellerCode);
    };
    if($@){
        print "Error ejecutando sentencia : $@"
    }

    $sth->finish();
    $dbh->disconnect();
}

1;
