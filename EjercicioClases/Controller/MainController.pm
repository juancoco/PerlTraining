package Controller::MainController;

use strict;
use warnings;
use Data::Dumper;
#use lib '/home/juaneduardo.cortes/Documents/PerlTraining/EjercicioClases';

use View::View;
use Model::User::Seller;
use Model::User::Buyer;
use Model::Product;
use Model::TransactionRegistry;
use Controller::DatabaseController;

my @sellers = ();
my @buyers = ();
my @products = ();
my @transactions = ();

sub new{
    my $class = shift;
    bless {}, $class;
    #return $self;
}

sub startApp{
    my $class = shift;
    
    my $exit;
    until($exit){
        my $option = View->mainMenu();
        
        if ($option eq 'createSeller') {
            createSeller();
        } elsif ($option eq 'createBuyer') {
            createBuyer();
        } elsif ($option eq 'createProduct') {
            createProduct()
        } elsif ($option eq 'createTransaction') {
            createTransaction();
        } elsif ($option eq 'createTransaction') {
            createTransaction();
        } elsif ($option eq 'listAvailableProducts') {
            listAvailableProducts();
        } elsif ($option eq 'exit') {
            $exit = 1;
        }
    }
}

sub createSeller{
    my @sellerData = View->inputForm();
    if(isDuplicatedId($sellerData[0]) eq 'no' && isValidEmail($sellerData[2]) eq 'yes'){
        my $seller = Model::User::Seller->new($sellerData[0], $sellerData[1], $sellerData[2], $sellerData[3], $sellerData[4]);
        Controller::DatabaseController->saveSeller($seller);
        #saveSeller($seller);
    }
}

sub createBuyer{
    my @buyerData = View->inputForm();
    if(idDuplicatedId($buyerData[0]) eq 'no' && isValidEmail($buyerData[2]) eq 'yes'){
        my $buyer = Model::User::Buyer->new($buyerData[0], $buyerData[1], $buyerData[2]);
        Controller::DatabaseController->saveBuyer($buyer); #hash with key table name
    }
}

sub createProduct{
    my @productData = View->inputForm();
    my $product = Model::Product->new($productData[0], $productData[1], $productData[2], 'yes');
    Controller::DatabaseController->saveProduct($product);
}

sub createTransaction{
    my @transactionData = View->inputForm();
    my $productToSell = Controller::DatabaseController->retrieveProductBySku($transactionData[1]);
    if($productToSell->getStatus eq 'yes'){
        my $transaction = Model::TransactionRegistry->new($transactionData[0], $transactionData[1]);
        Controller::DatabaseController->saveTransaction($transaction);
        $productToSell->setStatus('no');
    } else {
        print 'Product already selled';
    }
}

sub listAvailableProducts{
    my @pr = Controller::DatabaseController->retrieveProducts();
    View->showProducts(@pr);
    #foreach my $i (Controller::DatabaseController->retrieveProducts()){
    #    if($i->getStatus eq 'yes'){
    #        print $i->getProductDetail;
    #    }
    #}
}

sub saveSeller{
    my ($seller) = @_;
    push(@sellers, $seller);
    
    #print @sellers->[0]->id;
    
    foreach my $i (@sellers)
    {
        $i->getSellerCode;
        #print Dumper($i);
    }
}

sub saveBuyer{
    my ($buyer) = @_;
    push(@buyers, $buyer);
}

sub saveProduct{
    my ($product) = @_;
    push (@products, $product);
}

sub saveTransaction{
    my ($transaction) = @_;
    push (@transactions, $transaction);
}

sub isDuplicatedId{
    my ($id) = @_;
    foreach my $seller (@sellers)
    {
        if($id eq $seller->getId){
            #$duplicated = 'yes';
            print ('This id already exists. Cannot save' . "\n");
            #exit;
            return 'yes';
        }
    }
    return 'no';
}

sub isValidEmail{
    my ($email) = @_;
    if ( $email =~ /([a-zA-Z]+)\@([a-zA-Z]+)\.(com|net|org)/){
        return 'yes';
    } else {
        return 'no';
    }
}

1;
