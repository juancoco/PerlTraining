#!/usr/bin/env perl
use strict;
use warnings;

### FILE TYPES
# script.pl: Script plano
# Module.pm: Modulo

#########################################################################################
#	WELCOME TO PERL
#	Sponsored by:
##		- Perl Maven: https://perlmaven.com/perl-tutorial
##		- Globant basics of Perl Course: https://sites.google.com/a/globant.com/trainings-beta/training/perl
##		- Globant's Ticketmaster - RTB Team :)
##########################################################################################

## PRAGMA: Run instructions given to the Perl compiler.
# use strict;	-> Runs 'Safe' mode (recommended)
# use warnings;	-> Enables Perl compiler warnings (recommended)


##############################
# 1. BASIC DATA TYPES
##############################
# Scalars
# my/our
my $meeting_host_name = "Waiter";
# Array/List
my @day_time = ('morning','afternoon','evening');
# Hash
my %greetings_loption = (
	english 	=>	"Nice to meet you!",
	italiano 	=>	"E' un piacere!",
	espanol		=>	"Es un gusto conocerlo!",
);

my %menu = (
	plato1 	=>	"Ensalada",
	plato2 	=>	"Pescado",
	plato3	=>	"Asado",
);


#$farewell{english}...
# Undefined (A.K.A. as 'booleans' in perl)
my $should_offer_water; # implicitly setting it to 'undef'
#my $should_offer_water = 0;
#my $should_offer_water = '0';
#my $should_offer_water = '';
#my $should_offer_water = undef;
#my $should_offer_water = (); # empty list


##############################
# 3. SAMPLE SCRIPT
##############################

# Printing to STDOUT
my $welcome_message = ">>> WELCOME TO THE INTERNATIONAL RESTAURANT >>>\n";
my $close_message = ">>> COME BACK SOON >>>\n";
print $welcome_message;

# Accessing a specific position of the Array
my $moment_of_day = $day_time[1];

# Calling a subfeature (function) and passing a parameter
introduce($moment_of_day, $meeting_host_name);

# Calling another subfeature and store the result in a variable
my $user_name = ask_for_name();

print greet($user_name, %greetings_loption);

print validate_menu_option(ask_for_menu_option(), %menu);

# If defined, offer water
offer_water() if $should_offer_water;

# Finish the script
die( $close_message );


##############################
# 4. DAY 1 ACTIVITIES
##############################
# - Create a hash with the menu
# - For each menu option (dessert, drinks..), offer 3 items
# - Ask the user to select an option
# - Prepare each option the user asked

#menu:
#(
#	plato1: "ensalada",
#	plato2: "pescado",
#	plato3: "asado"
#)

#----------------
#1. "ensalada"
#2. "pescado"
#3. "asado"
#----------------
#Usuario: (plato1|plato2|plato3)
#----------------
#Preparando "ensalada" / la opcion '#' no esta disponible en el menu


##############################
# SUBROUTINES (functions)
##############################

sub introduce {
	my ($moment_of_day, $name) = @_; # SPECIAL VARS: @_ Sub Input parameters # $@ Errores/Exceptions
	print "Good " . $moment_of_day . "!, my name is $name\n";
}

sub ask_for_name {
	print "May I know your name?\n";
	# Read from STDIN
	my $name = <STDIN>;
	# 'chomp' is one of many of the special Perl features. 
	# This one removes new line char (<enter> key).
	chomp $name;
	return $name;
}

sub ask_for_menu_option {
	print "What do you want to order?\n";
	my $menuOption = <STDIN>;
	chomp $menuOption;
	return $menuOption;
}

sub validate_menu_option {
	my ($menuOption, %menu) = @_;
	
	unless($menuOption && $menu{$menuOption}){
		return "Menu option $menuOption is not available \n";
	}
	return "Cooking $menu{$menuOption} \n";
	
	#if($menuOption && $menu{$menuOption}){
	#	return "Cooking $menu{$menuOption} \n";
	#} else {
	#	return "Menu option $menuOption is not available \n";
	#}
}

sub offer_water {
	print "Let me bring you some water :)\n";
}

sub greet {
	my ($username, %farewell_options) = @_;

	my $farewell_message = "";

	# Control structure: <IF> Strings: eq=equivalent / ne= notequivalent
	# "abc" eq "bcd" -> false
	# "abc" ne "bcd" -> true
	# 123 == 234 -> false
	# 123 != 234 -> true

	if ($username eq "Paul") {
		# Accessing a specific key of the hash
		$farewell_message = $farewell_options{english} . "\n";
	} elsif ($username eq "Paolo") {
		# Accessing a specific key of the hash
		$farewell_message = $farewell_options{italiano} . "\n";
	} elsif ($username eq "Pablo") {
		# Accessing a specific key of the hash
		$farewell_message = $farewell_options{espanol} . "\n";
	} else {
		$farewell_message = "Nice name, $user_name \n";
	}

	return $farewell_message;
}
