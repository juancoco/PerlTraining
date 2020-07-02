package Model::User::Buyer;

use strict;
use warnings;
use Data::Dumper;

use Model::User;
use Controller::DatabaseController;

our @ISA = qw(Model::User);

sub save{
    my ($self, $buyer) = @_;
    Controller::DatabaseController->save('buyers', $buyer);
}

1;
