package Model::Contact;

use strict;
use warnings;
use Moo;
use JSON::XS;
use JSON;
use Service::RequestHandler;
use Data::Dumper;

has id => (is => 'rw');
has name => (is => 'rw');
has email => (is => 'rw');
has phone => (is => 'rw');

sub newContact {
    my ( $class ) = @_;
    my $response = Service::RequestHandler->createContact();
    my %contact_attrs =(
        id => $response->{id},
        name => $response->{name},
        email => $response->{email},
        phone => $response->{phone},
    );
    return Model::Contact->new(\%contact_attrs);
}

sub getAll {
    my ( $class ) = @_;
    my $response = Service::RequestHandler->getAllContacts();
    my @contacts;
    #print $response->{data}[1]->{name};   #funca

    for (my $i=0; $i <= 3; $i++) {
        #print $response->{data}[$i]->{name} . "\n";
        my %contact_attrs =(
            id => $response->{data}[$i]->{id},
            name => $response->{data}[$i]->{name},
            email => $response->{data}[$i]->{email},
            phone => $response->{data}[$i]->{phone},
        );
        push(@contacts, Model::Contact->new(\%contact_attrs));
    }
    return @contacts;
}

sub deleteContact {
    my ( $class, $id ) = @_;
    my $response = Service::RequestHandler->deleteContact($id);
    return $response;
}

sub updateContact {
    my ( $class, $id ) = @_;
    my $response = Service::RequestHandler->updateContact($id);
    return $response;
}

1;
