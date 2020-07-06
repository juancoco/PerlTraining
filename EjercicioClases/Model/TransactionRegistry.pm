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

sub save{
    my ($class, $transaction) = @_;
    Controller::DatabaseController->save('transactions', $transaction);
}

1;
