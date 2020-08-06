package Controller::MainController;

use strict;
use warnings;
use View::Display;
use Model::Contact;

sub new{
    my $class = shift;
    bless {}, $class;
    return $class;
}

sub startApp{
    my $class = shift;
    
    my $exit;
    until($exit){
        my $option = View::Display->mainMenu();
        
        if ($option eq 'post') {
            postmethod();
        } elsif ($option eq 'get') {
            getmethod();
        } elsif ($option eq 'delete') {
            deletemethod();
        } elsif ($option eq 'update') {
            updatemethod();
        } elsif ($option eq 'exit') {
            $exit = 1;
        }
    }
}

sub postmethod {
    my $contact = Model::Contact->newContact;
    View::Display->showResult($contact);
}

sub getmethod {
    my @contacts = Model::Contact->getAll();
    View::Display->showResults(@contacts);
}

sub deletemethod {
    my $idToDelete = View::Display->askForId();
    my $dcontact = Model::Contact->deleteContact($idToDelete);
    View::Display->showResult($dcontact);
}

sub updatemethod {
    my $idToUpdate = View::Display->askForId();
    my $ucontact = Model::Contact->updateContact($idToUpdate);
    View::Display->showResult($ucontact);
}

1;
