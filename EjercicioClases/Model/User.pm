package Model::User;

use strict;
use warnings;
use Data::Dumper;

sub new{
    my $class = shift;
    my $self = {
        id => shift,
        name => shift,
        email => shift,
    };
    
    bless $self, $class;
    return $self;
}

sub setId {
   my ( $self, $id ) = @_;
   $self->{ id } = $id if defined($id);
   return $self->{id};
}

sub setName {
   my ( $self, $name ) = @_;
   $self->{ name } = $name if defined($name);
   return $self->{name};
}

sub setEmail {
   my ( $self, $email ) = @_;
   $self->{ email } = $email if defined($email);
   return $self->{email};
}

sub getId {
   my( $self ) = @_;
   return $self->{id};
}

sub getName {
   my( $self ) = @_;
   return $self->{name};
}

1;
