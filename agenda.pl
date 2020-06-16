#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

my @menu = ("1.Print Contacts", "2.Add Contact", "3.Call Contact", "0.Exit");

my @contacts;

my $exit;

until($exit){
    
    foreach my $menuOption (@menu) {
        print $menuOption . "\n";
    }
    
    my $answer = (<STDIN>);
    chomp $answer;
    if($answer && $answer eq 1){
        printContacts(@contacts);
    } elsif ($answer eq 2){
        @contacts = addContact(@contacts);
    } elsif ($answer eq 3){
        callContact(@contacts);
    } elsif ($answer eq 0){
        print "Bye \n";
        $exit = 1;
    }
}



sub printContacts {
    my (@contacts) = @_;
    foreach my $myContact (@contacts){
        foreach my $contact (keys %{$myContact}){
            print $contact . " - " . $myContact->{$contact} . "\n";
        }
    }
}

sub addContact {
    my (@contacts) = @_;
    print "Ingrese nombre: \n";
    my $name = (<STDIN>);
    print "Ingrese numero: \n";
    my $number = (<STDIN>);
    chomp $name;
    chomp $number;
    push @contacts, {$name => $number,};
    return @contacts;
}

sub callContact {
    my (@contacts) = @_;
    print "Who would you like to call? \n";
    my $contact = (<STDIN>);
    chomp $contact;
    
    foreach my $myContact (@contacts){
        if($myContact->{$contact}){
            print "Calling: " . $myContact->{$contact} . "\n";
        } else {
            print "Sorry i dont know that contact \n";
        }
    }
}
