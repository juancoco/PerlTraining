package View::Display;

use strict;
use warnings;
use Data::Dumper;

my @options = ("1.POST", "2.GET", "3.DELETE", "4.UPDATE", "0.Exit");

sub mainMenu{
    foreach my $option (@options) {
        print $option . "\n";
    }
    
    my $answer = (<STDIN>);
    chomp $answer;
    
    if($answer && $answer eq '1'){
        return 'post';
    } elsif ($answer eq '2'){
        return 'get';
    } elsif ($answer eq '3'){
        return 'delete';
    } elsif ($answer eq '4'){
        return 'update';
    } elsif ($answer eq '0'){
        print "Come back soon \n";
        return 'exit';
    }
}

sub askForId {
    print "Ingrese el Id... \n";
    my $id = <STDIN>;
	chomp $id;
	return $id;
}

sub showResult {
    my ($class, $info) = @_;
    print Dumper($info);
}

sub showResults {
    my ($class, @info) = @_;
    print Dumper(@info);
}

1;
