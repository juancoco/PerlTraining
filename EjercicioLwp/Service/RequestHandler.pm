package Service::RequestHandler;

use strict;
use warnings;
use LWP;
use LWP::UserAgent;
use JSON::XS;

sub new{
    my $class = shift;
    bless {}, $class;
    return $class;
}

my $baseurl = 'https://api.stripe.com/v1/customers';
my $authToken = 'Bearer sk_test_51H09DBIqROD6QbKkjbcqNXhzQBNqsslqAsZCyodTMuhZgZoJ5j6LJdcvqLXfkXbOsNnI6ke43zz6v8H8WENk33rF00mgegUCEe';

my $ua = LWP::UserAgent->new;
$ua->agent("MyApp/0.1 ");

sub createContact {
    my $req = HTTP::Request->new(POST => $baseurl);
    $req->header('Authorization' => $authToken);
    my $res = $ua->request($req);
    if ($res->is_success) {
        return decode($res);
    }
    else {
        print $res->status_line, "\n";
    }
}

sub getAllContacts {
    my $req = HTTP::Request->new(GET => $baseurl);
    $req->header('Authorization' => $authToken);
    my $res = $ua->request($req);
    if ($res->is_success) {
        return decode($res);
    }
    else {
        print $res->status_line, "\n";
    }
}

sub deleteContact {
    my ($class, $id) = @_;
    my $req = HTTP::Request->new(DELETE => $baseurl . $id);
    $req->header('Authorization' => $authToken);
    my $res = $ua->request($req);
    if ($res->is_success) {
        return decode($res);
    }
    else {
        print $res->status_line, "\n";
    }
}

sub updateContact {
    my ($class, $id) = @_;
    my $req = HTTP::Request->new(POST => $baseurl . $id);
    $req->header('Authorization' => $authToken);
    $req->content_type('application/x-www-form-urlencoded');
    $req->content('name=camilo');
    
    my $res = $ua->request($req);
    if ($res->is_success) {
        return decode($res);
    }
    else {
        print $res->status_line, "\n";
    }
}

sub decode {
    my ($res) = @_;
    my $perl_scalar;
    eval{
        $perl_scalar = decode_json $res->content;
    };
    if($@){
        die "Error decoding json : $@";
    }else{
        return $perl_scalar;
    }
}

1;
