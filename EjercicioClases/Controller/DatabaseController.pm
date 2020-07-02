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
    return $class;
}

my %tables = (
	sellers => [],
	buyers => [],
	products => [],
    transactions => [],
);

sub save{
    my ($class, $tablename, $object) = @_;
    
    foreach my $key (keys %tables) {
        if($key eq $tablename){
            push( @{$tables{$key}}, $object );
        }
    }
}

sub retrieveUsers{
    return @{$tables{'sellers'}};
}

sub retrieveProducts{
    return @{$tables{'products'}};
}

sub retrieveTransactions{
    return @{$tables{'transactions'}};
}

1;
