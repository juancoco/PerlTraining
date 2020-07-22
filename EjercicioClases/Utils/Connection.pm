package Utils::Connection;

use DBI;

sub new{
    my $class = shift;
    bless {}, $class;
    return $class;
}


sub dbconnect {
  my $dbConnectionString="DBI:mysql:database=PERL_STORE;host=172.17.0.2;mysql_local_infile1";
  my $dbLogin="root";
  my $dbPassword="1234";
  my $dbh;
  eval{
    $dbh = DBI->connect($dbConnectionString, $dbLogin, $dbPassword);
  };
  if($@){
    die "Error conectando a db : $@";
  }
  return $dbh;
}

1;
