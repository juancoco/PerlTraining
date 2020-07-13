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
    my $dbh = DBI->connect($dbConnectionString, $dbLogin, $dbPassword, {RaiseError => 1}) or die (" No se pudo conectar: " . DBI->errstr);

    my $sth = $dbh->prepare(
        "INSERT INTO transactions (sku, seller_code) values (?,?)"
    );
    $sth->execute($transaction->getSku, $transaction->getSellerCode) or die $DBI::errstr;
   
    $sth->finish();
    $dbh->disconnect();
}

1;
