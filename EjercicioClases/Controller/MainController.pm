package Controller::MainController;

use strict;
use warnings;
use Data::Dumper;

use View::View;
use Model::User::Seller;
use Model::User::Buyer;
use Model::Product;
use Model::TransactionRegistry;
use Controller::DatabaseController;

sub new{
    my $class = shift;
    bless {}, $class;
    return $class;
}

sub startApp{
    my $class = shift;
    
    my $exit;
    until($exit){
        my $option = View::View->mainMenu();
        
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
    my @sellerData = View::View->inputForm();
    my $seller = Model::User::Seller->new($sellerData[0], $sellerData[1], $sellerData[2], $sellerData[3], $sellerData[4]);
    if($seller->isDuplicatedId($seller->getId) eq 'no' && $seller->isValidEmail($seller->getEmail)){
        $seller->save($seller);
    }
}

sub createBuyer{
    my @buyerData = View::View->inputForm();
    my $buyer = Model::User::Buyer->new($buyerData[0], $buyerData[1], $buyerData[2]);
    if($buyer->isDuplicatedId($buyer->getId) eq 'no' && $buyer->isValidEmail($buyer->getEmail)){
        $buyer->save($buyer);
    }
}

sub createProduct{
    my @productData = VView::iew->inputForm();
    Model::Product->save(Model::Product->new($productData[0], $productData[1], $productData[2], 'yes'));
}

sub createTransaction{
    my @transactionData = View::View->inputForm();
    my $productToSell = Model::Product->getProductBySku($transactionData[1]);
    if($productToSell->getStatus eq 'yes'){
        my $transaction = Model::TransactionRegistry->new($transactionData[0], $transactionData[1]);
        $transaction->save;
        $productToSell->setStatus('no');
    } else {
        print 'Product already selled';
    }
}

sub listAvailableProducts{
    View::View->showProducts(Model::Product->getProducts);
}

1;
