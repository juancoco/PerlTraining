package Model::User;

use strict;
use warnings;

use Utils::Connection;

sub new{
   my ( $class, $args ) = @_;
   my $self = {
      id => $args->{id} || "",
      name => $args->{name} || "",
      email => $args->{email} || "",
   };
   
   bless $self, $class;
   return $self;
}

sub getId {
   my( $self ) = @_;
   return $self->{id};
}

sub getName {
   my( $self ) = @_;
   return $self->{name};
}

sub getEmail {
   my( $self ) = @_;
   return $self->{email};
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

sub isDuplicatedId{
    my ($class, $id) = @_;
    my @users = Controller::DatabaseController->retrieveUsers;
    foreach my $user (@users)
    {
      if($id eq $user->getId){
         return undef;
      }
    }
    return 1;
}

sub isValidEmail{
    my ($class, $email) = @_;
    if ( $email =~ /([a-zA-Z]+)\@([a-zA-Z]+)\.(com|net|org)/){
        return 1;
    } else {
        return undef;
    }
}

sub saveUser{
   my ($class, $object) = @_;

   my $dbh = Utils::Connection->dbconnect();
   my $socialReason = UNIVERSAL::can($object, "getSocialReason") ? $object->getSocialReason() : undef;
   my $sellerCode =  $object->can("getSellerCode") ? $object->getSellerCode() : undef;
   my $sth = $dbh->prepare(
      "INSERT INTO user (id, name, email, social_reason, seller_code) values (?,?,?,?,?)"
   );
   eval{
      $sth->execute($object->getId, $object->getName, $object->getEmail, $socialReason, $sellerCode);
   };
   if($@){
      die "Error ejecutando sentencia : $@";
   }
   
   $sth->finish();
   $dbh->disconnect();
}

1;
