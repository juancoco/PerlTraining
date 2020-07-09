package View::View;

use strict;
use warnings;
use Data::Dumper;

my @options = ("1.Registrar vendedor", "2.Registrar comprador", "3.Registrar producto", "4.Registrar venta", "5.Listar productos", "0.Exit");

sub mainMenu{
    foreach my $option (@options) {
        print $option . "\n";
    }
    
    my $answer = (<STDIN>);
    chomp $answer;
    
    if($answer && $answer eq '1'){
        print 'Ingrese numero de identificacion, nombre, email, razon social y codigo de vendedor' . "\n";
        return 'createSeller';
    } elsif ($answer eq '2'){
        print 'Ingrese numero de identificacion, nombre y email' . "\n";
        return 'createBuyer';
    } elsif ($answer eq '3'){
        print 'Ingrese sku, nombre y codigo de vendedor' . "\n";
        return 'createProduct';
    } elsif ($answer eq '4'){
        print 'Ingrese id del comprador y sku del producto' . "\n";
        return 'createTransaction';
    } elsif ($answer eq '5'){
        return 'listAvailableProducts';
    } elsif ($answer eq '0'){
        print "Come back soon \n";
        return 'exit';
    }
}

sub inputForm{
    my $data = <STDIN>;
	chomp $data;
    my @splitedData = split(",", $data);
	return @splitedData;
}

sub showProducts{
    my ($class, @products) = @_;
    foreach my $product (@products){
        if($product->hasStock){
            print $product->getProductDetail . "\n";
        }
    }
}

sub showMessage{
    my ($class, $message) = @_;
    print $message . "\n";
}

1;
