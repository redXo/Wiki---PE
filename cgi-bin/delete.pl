#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

print "Content-type: text/html\n\n";
print <<HTML;
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="../CSS/nw3.css" />
    <title>DELETE</title>
  </head>
  <body>
HTML

#CGI part
my $cgi = CGI->new;
my $name = $cgi->param('name');

#Database part
my $user= 'alumno';
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.0.102";
my $dbh = DBI->connect($dsn, $user, $password) or die ("No se puede conectar");
#Eliminar datos
my $sth = $dbh->prepare("DELETE from wiki WHERE name=?");
$sth->execute($name);

$dbh->disconnect;

print <<HTML;
    <div class="box_form2">
        <h1 class="title-delete">La página ha sido eliminada</h1>
        <form action="list.pl">
           <input class="boton2" type="submit" value="VOLVER\n A LA LISTA" />
        </form>
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
