package Controller::DatabaseController;

use strict;
use warnings;
use Data::Dumper;

use Model::User::Seller;
use Model::User::Buyer;
use Model::Product;
use Model::TransactionRegistry;

sub new{
    my $class = shift;
    bless {}, $class;
    #return $self;
}

my @sellers = ();
my @buyers = ();
my @products = ();
my @transactions = ();

sub saveSeller{
    my ($class, $seller) = @_;
    push(@sellers, $seller);
}

sub saveBuyer{
    my ($class, $buyer) = @_;
    push(@buyers, $buyer);
}

sub saveProduct{
    my ($class, $product) = @_; #Forma indicada
    push (@products, $product);
}

sub saveTransaction{
    my ($class, $transaction) = @_;
    push (@transactions, $transaction);
}

sub save{
    my ($tablename, $transaction) = @_;
}

sub retrieveProducts{
    return @products;
}

sub retrieveProductBySku{
    my ($class, $sku) = @_;
    print Dumper(@products) . "\n";
    foreach my $pr (@products){
        return $pr;
    }
}

sub retrieveTransactions{
    return @products;
}

1;
