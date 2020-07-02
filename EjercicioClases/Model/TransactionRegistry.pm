package Model::TransactionRegistry;

use strict;
use warnings;
use Data::Dumper;

use Controller::DatabaseController;

sub new{
    my $class = shift;
    my $self = {
        sku => shift,
        sellerCode => shift,
    };
    
    bless $self, $class;
    return $self;
}

sub save{
    my ($class, $transaction) = @_;
    Controller::DatabaseController->save('transactions', $transaction);
}

1;
