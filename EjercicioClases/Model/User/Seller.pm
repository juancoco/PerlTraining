package Model::User::Seller;

use strict;
use warnings;
use Data::Dumper;

use Model::User;

our @ISA = qw(Model::User);

sub new {
    my ($class) = @_;
    
    # Call the constructor of the parent class, Person.
    my $self = $class->SUPER::new( $_[1], $_[2], $_[3] );
    # Add few more attributes
    $self->{socialReason}   = $_[4];
    $self->{sellerCode} = $_[5];
    bless $self, $class;
    return $self;
}

sub getSellerCode {
    my( $self ) = @_;
    return $self->{sellerCode};
}

1;
