package Controller::MainController;

use strict;
use warnings;

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
    my %seller_attrs = (
        id => $sellerData[0],
        name => $sellerData[1],
        email => $sellerData[2],
        socialReason => $sellerData[3],
        sellerCode => $sellerData[4],
    );

    my $seller = Model::User::Seller->new(\%seller_attrs);
    if($seller->isDuplicatedId($seller->getId()) && $seller->isValidEmail($seller->getEmail())){
        $seller->save();
        View::View->showMessage('Seller saved succesfully');
    } else {
        View::View->showMessage('Seller has duplicated id or invalid email');
    }
}

sub createBuyer{
    my @buyerData = View::View->inputForm();
    my %buyer_attrs = (
        id => $buyerData[0],
        name => $buyerData[1],
        email => $buyerData[2],
    );

    my $buyer = Model::User::Buyer->new(\%buyer_attrs);
    if($buyer->isDuplicatedId($buyer->getId()) && $buyer->isValidEmail($buyer->getEmail())){
        $buyer->save();
        View::View->showMessage('Buyer saved succesfully');
    } else {
        View::View->showMessage('Buyer has duplicated id or invalid email');
    }
}

sub createProduct{
    my @productData = View::View->inputForm();
    my %product_attrs = (
        sku => $productData[0],
        name => $productData[1],
        sellerCode => $productData[2],
        isAvailable => '1',
    );
    my $product = Model::Product->new(\%product_attrs);
    $product->save();
}

sub createTransaction{
    my @transactionData = View::View->inputForm();
    my $productToSell = Model::Product->getProductBySku($transactionData[1]);
    if($productToSell->hasStock()){
        my %transaction_attrs = (
            sku => $transactionData[0],
            sellerCode => $transactionData[1],
        );
        my $transaction = Model::TransactionRegistry->new(\%transaction_attrs);
        $transaction->save();
        $productToSell->updateStock(undef);
    } else {
        View::View->showMessage('Product already selled');
    }
}

sub listAvailableProducts{
    View::View->showProducts(Model::Product->getProducts());
}

1;
