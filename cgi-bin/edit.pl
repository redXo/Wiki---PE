#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

my $q = CGI->new;
my $name = $q->param('name');
print $q->header('text/html;charset=UTF-8');

my $user = 'alumno';
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.0.102";
my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar!");;

my $sth = $dbh->prepare("SELECT markdown FROM wiki WHERE name=?");
$sth->execute($name);
my @row;
my @text;
while (@row = $sth->fetchrow_array){
  push (@text,@row);
}

$sth->finish;
$dbh->disconnect;

my $body = renderBody($name,@text);
print renderHTMLpage('Edit',$body);

sub renderBody{
  my $name = $_[0];
  my $markdown = $_[1];
  my $body = <<"BODY";
  <div class='box_form'>
    <h1><strong class="mk">Nombre:</strong> $name</h1>
    <form action="new.pl">
        <label class="nm" for="markdown"><strong>Contenido</strong></label>
        <textarea class="input-text" id="cuadro_texto" name="markdown" required>$markdown</textarea>
        
        <input type="hidden" name="name" value="$name"><br><br/>
        <input class="boton"type="submit" id="boton_submit" value="Editar">
    </form>
    
    <a href="list.pl"><button class="boton">Cancelar</button></a>
  </div>
BODY
  return $body;
}

sub renderHTMLpage{
  my $title = $_[0];
  my $body = $_[1];
my $html = <<"HTML";
  <!DOCTYPE html>
  <html lang="es">
    <head>
      <title>$title</title>
      <link rel="stylesheet" href="../CSS/nw3.css">

      <meta charset="UTF-8">
    </head>
    <body>
      $body

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
  return $html;
}
