#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

print "Content-type: text/html\n\n";
print <<HTML;
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="../CSS/nw3.css" />
    <title>LIST</title>
  </head>
  <body>
    <div class="box_form">
         <h1>Tu<strong class="mk">(s)</strong> página<strong class="mk">(s)</strong> creada<strong class="mk">(s)</strong> en la <strong class="mk">Wiki</strong></h1>
         <div class="ult">
HTML

#Base de datos
my $user = 'alumno';
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.0.102";
my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar!");;

my $sth = $dbh->prepare("SELECT name FROM wiki");
$sth->execute();
print "<ul>\n";
while(my @row = $sth->fetchrow_array){
    print "<li>\n";
      print "<a href='view.pl?name=@row'>@row</a>";
      print "<a href='delete.pl?name=@row'><button>DEL</button></a>\n";
      print "<a href='edit.pl?name=@row'><button>EDT</button></a>\n";
    print "</li>\n";
}
print "</ul>\n";
$sth->finish;
$dbh->disconnect;

print <<HTML;
      </div>

      <a href="../index.html"><button class="boton">INICIO</button></a>
      <a href="../new.html"><button class="boton">NUEVA P.</button></a>

    </div>
    <div class="Figuras">
      <div class="cd"></div>
      <div class="cd"></div>
      <div class="cd"></div>
      <div class="cd"></div>
      <div class="cd"></div>
      <div class="cd"></div>
      <div class="cd"></div>
      <div class="cd"></div>
      <div class="cd"></div>
      <div class="cd"></div>
    </div>
  </body>
</html>
HTML
