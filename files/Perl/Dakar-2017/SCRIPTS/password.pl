#!/usr/bin/perl

# Programme : password.pl 
# - demande un login
# - demande un password
# - message different selon le mot de passe

use strict;
use warnings;

#### Demande le login
print "#################################\n";
print "# Comment vous appelez-vous ?\n ";
print "#################################\n";
my $nom = <>; # Récupération du nom de l'utilisateur


print "\n\n******* Bonjour $nom sans chomp! *******\n";

chomp $nom;   # Retrait du saut de ligne
print "\n\n******* Bonjour, $nom avec chomp! *******\n";


#### Demande le mot de passe
print "\n\n#################################\n";
print "# Alors quel mot de passe ? \n";
print "#################################\n";

my $passwd = <>;
chomp $passwd;

print "\n\n**********************************************";

if ($passwd eq "stp")
{
    print "\n******* ACCES AUTORISE.... Bienvenue $nom....  *******\n";
}
else
{
    print "\n\n******* DOMMAGE, MOT DE PASSE ERRONE.... Essaye encore $nom....  *******\n";
}

print "**********************************************\n\n";
