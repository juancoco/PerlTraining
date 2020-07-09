package Model::User::Buyer;

use strict;
use warnings;
use Data::Dumper;

use Model::User;
use Controller::DatabaseController;

our @ISA = qw(Model::User);

sub save{
    
    my ( $class, $args ) = @_;
    my $local_instance = $class->SUPER::new($args);
    return $local_instance;
}

sub save{
    my ($self) = @_;
    Controller::DatabaseController->save('buyers', $self);
}

1;
