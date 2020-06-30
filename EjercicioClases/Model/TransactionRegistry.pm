package Model::TransactionRegistry;

use strict;
use warnings;
use Data::Dumper;



sub new{
    my $class = shift;
    my $self = {
        sku => shift,
        sellerCode => shift,
    };
    
    bless $self, $class;
    return $self;
}


1;
