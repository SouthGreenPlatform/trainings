---
layout: page
title: "Python Practice"
permalink: /python/pythonPractice/
tags: [ Python, survival guide ]
description: Python Practice page
---

| Description | Hands On Lab Exercises for Python |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [Python introduction](https://southgreenplatform.github.io/trainings//python/) |
| Creation Date | 2017 |
| Last Modified Date | 13/05/2019    |


-----------------------

### Summary

* [Pratique 1: Premier script](#practice-1)
* [Pratique 2: Les tests](#practice-2)
* [Pratique 3: Les listes et les boucles](#practice-3)
* [Pratique 4: Les listes et les boucles suite](#practice-4)
* [Pratique 5: Le passage de paramètre](#practice-5)
* [Pratique 6: Les fichiers](#practice-6)
* [Pratique 7: Les dictionnaires](#practice-7)
* [Pratique 8: bioPython Seq, SeqRecord et SeqIO](#practice-8)

* [Links](#links)
* [License](#license)

-----------------------

<a name="practice-1"></a>
### Pratique 1: Premier script

#### Mode interactif

En mode interactif, demander à l'interpréteur de calculer
{% highlight python %}
5*6
10/3
10.0/3.0
print("Hello world !")
{% endhighlight %}

Rappel mode interactif
* ouvrir un terminal
* lancer l'interpréteur python via la commande *ipython*
* taper les instructions souhaitées

#### Mode script

Créer un programme python qui affiche "Hello world"
* Créer un fichier hello.py avec votre    éditeur de texte (nano, …)
* Taper l'instruction {% highlight python %} print("Hello world"){% endhighlight %} dans le fichier
* Enregistrer le fichier
* Dans le terminal, se déplacer dans le répertoire où se trouve mon script (commande cd …)
* Exécuter le script en tapant la commande {% highlight bash %}python3 hello.py{% endhighlight %}

OU

* Créer un fichier hello2.py avec un éditeur de texte (gedit, Emacs, nano, …)
* Taper en 1er ligne du fichier : #!/usr/bin/env python3
* Taper l'instruction {% highlight python %}print("Hello world"){% endhighlight %} dans le fichier
* Enregistrer le fichier
* Dans le terminal, se déplacer dans le répertoire où se trouve mon script (commande cd …)
* Lancer la commande chmod +x hello2.py
* Exécuter le script en tapant la commande {% highlight bash %}./hello2.py{% endhighlight %}

-----------------------

<a name="practice-2"></a>
### Pratique 2: Les tests:

Créer un programme python exo2.py qui affiche la moyenne de 3 notes données par l'utilisateur.
Voici le code python3 pour demander 3 valeurs à l'utilisateur qui seront stockées dans les variables note1, note2, note3:
{% highlight python %}
note1 = input("Donner une note : ")
note2 = input("Donner une note : ")
note3 = input("Donner une note : ")
{% endhighlight %}
*!! Attention les variables note1, note2, note3 sont de type chaîne de caractère !!*

Modifier votre programme précédent afin qu'il affiche
* "ajourné" si la moyenne est inférieure à 10
* "passable" si la moyenne est supérieure ou égale à 10
* "assez bien" si la moyenne est supérieure ou égale à 12
* "bien" si la moyenne est supérieure ou égale à 14
* "très bien" si la moyenne est supérieure ou égale à 16

-----------------------

<a name="practice-3"></a>
### Pratique 3: Les listes et les boucles :

Soit la liste suivante:
{% highlight python %}liste_animaux = ['vache','souris','levure','bacterie']{% endhighlight %}

* Créer un programme python *exo3_for.py* qui affiche l’ensemble des éléments de la liste *liste_animaux* en utilisant la boucle *for*

* Créer un programme python *exo3_while.py* qui affiche l’ensemble des éléments de liste *liste_animaux* en utilisant la boucle *while*

Soit la liste de nombres suivante
{% highlight python %}impairs = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21]{% endhighlight %}

* Créer un programme python *exo4.py* qui, à partir de la liste impairs, construit une nouvelle liste pairs dans laquelle tous les éléments de impairs sont incrémentés de 1. Une fois la nouvelle liste créée, l'afficher (faire avec for et while).

-----------------------

<a name="practice-4"></a>
### Pratique 4: Les listes et les boucles suite :

* Créer un programme python *exo5.py* qui à partir de la séquence nucléique "TCTGTTAACCATCCACTTCG" (chaîne de caractères) crée sa séquence complémentaire inverse, puis l'affiche.

* Créer un programme python *exo6.py* qui compte le nombre de chacune des bases (A, T, G, C) présente dans la séquence nucléique "TCTGTTAACCATCCACTTCG", puis qui affiche ces nombres. Vous ferez une version qui utilise la fonction count() des listes et une autre version qui ne l'utilise pas.

* Créer un programme python *exo7.py* qui vérifie si la sous-séquence "ATG" (codon start) est présente dans la séquence nucléique "TCTGTTATGACCATCCACTTCG", puis affiche "oui" ou "non" en fonction du résultat.

* Modifier le programme précédent exo6.py pour qu'il affiche également la position de la sous-séquence "ATG" si elle est présente.

* Reprendre l'un des programmes *exo5.py*, *exo6.py* ou *exo7.py* et faire en sorte qu'il fonctionne pour plusieurs séquences (les séquences seront stockées dans une liste et pour chacune des séquences sera analysée)
Exemple :
{% highlight python %}
seq1= "ATGCGTAGTCGT"
seq2= "AGGTTCGTATG"
mes_seq = [seq1,seq2]
{% endhighlight %}

-----------------------

<a name="practice-5"></a>
### Pratique 5: Le passage de paramètre :

* Reprendre le programme *exo6.py* et créer un nouveau programme python *exo6_arg.py* qui permettra de donner la séquence nucléique étudiée en argument du programme.

* Modifier le programme précédent *exo6_arg.py* afin de vérifier la présence du bon nombre d'arguments

* Créer un programme python exo8.py qui permet de comparer 2 séquences données en argument et qui affiche le nombre de résidus identiques à la même position entre les 2 séquences (on considère que les 2 séquences sont de même longueur)
Exemple :
avec les séquences "ATTGCTA" et "ATTGCTC", le programme doit afficher " 6 résidus identiques"
avec les séquences "TAATTGT" et "ATTGCTC", le programme doit afficher " 0 résidus identiques"

* Modifier le programme précédent *exo8.py* afin d'afficher le pourcentage d'identité (nb résidu identique / nb de résidu total)

* Modifier le programme précédent *exo8.py* afin d'autoriser des séquences de longueurs différentes.

-----------------------

<a name="practice-6"></a>
### Pratique 6: Les fichiers :

* Voila une séquence au format fasta (/path/to/sequence/sequence1.fasta):
{% highlight fasta %}
>gi|374429558|ref|NR_046237.1| Rattus norvegicus 18S ribosomal RNA (Rn18s), ribosomal RNA
TACCTGGTTGATCCTGCCAGTAGCATATGCTTGTCTCAAAGATTAAGCCATGCATGTCTAAGTACGCACG
GCCGGTACAGTGAAACTGCGAATGGCTCATTAAATCAGTTATGGTTCCTTTGGTCGCTCGCTCCTCTCCT
{% endhighlight %}

* Créer un programme python *exo9.py* qui permet de lire le fichier *sequence1.fasta* (dont le nom est passé en argument) contenant la séquence au format fasta et qui affiche cette séquence


* Créer un programme python *exo10.py* qui permet de lire un fichier (dont le nom est passé en argument) contenant la séquence au format fasta et qui affiche les résidus de la séquence écrits en minuscule (pas l’en-tête fasta ">....").
Exemple d'affichage :
{% highlight fasta %}
tacctggttgatcctgccagtagcatatgcttgtctcaaagattaagccatgcatgtctaagtacgcacg
gccggtacagtgaaactgcgaatggctcattaaatcagttatggttcctttggtcgctcgctcctctcct
acttggataactgtggtaattctagagctaatacatgccgacgggcgctgaccccccttcccgtgggggg
aacgcgtgcatttatcagatcaaaaccaacccggtcagccccctcccggctccggccgggggtcgggcgc
cggcggctttggtgactctagataacctcgggccgatcgcacgtccccgtggcggcgacgacccattcga
{% endhighlight %}

* Créer un programme python *exo11.py* qui permet de lire un fichier (dont le nom est passé en argument) contenant la séquence au format fasta et qui affiche une ligne sur 2 de la séquence fasta : ligne 1 puis 3 puis 5 …
Exemple d'affichage :
{% highlight fasta %}
>gi|374429558|ref|NR_046237.1| Rattus norvegicus 18S ribosomal RNA (Rn18s), ribosomal RNA
GCCGGTACAGTGAAACTGCGAATGGCTCATTAAATCAGTTATGGTTCCTTTGGTCGCTCGCTCCTCTCCT
AACGCGTGCATTTATCAGATCAAAACCAACCCGGTCAGCCCCCTCCCGGCTCCGGCCGGGGGTCGGGCGC
{% endhighlight %}

--------------------------

Details de l’en-tête d'une séquence au format fasta (/path/to/sequence/sequence2.fasta)
{% highlight fasta %}
>gi|374429558|ref|NR_046237.1| Rattus norvegicus 18S ribosomal RNA (Rn18s), ribosomal RNA
{% endhighlight %}

* Créer un programme python *exo12.py* qui permet de lire un fichier (passé en argument) contenant plusieurs séquences au format fasta et qui affiche les en-têtes de ces séquences.
* Modifier le programme précédent *exo12.py* pour qu'il crée un fichier résultat ne contenant que les en-têtes des séquences fasta (en plus de l'affichage). Le nom du fichier résultat sera passé en argument.

Exemple de fichier résultat :
{% highlight fasta %}
>gi|374429558|ref|NR_046237.1| Rattus norvegicus 18S ribosomal RNA (Rn18s), ribosomal RNA
>gi|374429558|ref|NR_046237.1| Rattus norvegicus 18S ribosomal RNA (Rn18s), ribosomal RNA
>gi|374429558|ref|NR_046237.1| Rattus norvegicus 18S ribosomal RNA (Rn18s), ribosomal RNA
>gi|374429558|ref|NR_046237.1| Rattus norvegicus 18S ribosomal RNA (Rn18s), ribosomal RNA
{% endhighlight %}

* Créer un programme python *exo13.py* qui permet de lire un fichier (passé en argument) contenant plusieurs séquences au format fasta et qui crée un fichier résultat (passé en argument) qui devra contenir uniquement le numéro gi et le numéro d'accession de chaque séquence du fichier d'entrée.

Exemple de fichier résultat :
{% highlight fasta %}
seq 1 => num gi : 374429558, num accession : NR_046237.1
seq 2 => num gi : 374429558, num accession : NR_046237.1
seq 3 => num gi : 374429558, num accession : NR_046237.1
{% endhighlight %}

* Créer un programme *exo14.py* qui doit prendre en argument un fichier tabulé contenant 2 colonnes numériques et écrire un nouveau fichier tabulé en sortie contenant les 2 colonnes originales et une 3ème colonne contenant leur somme.
Les noms des fichiers d'entrée et de sortie doivent être pris en argument.  
La première ligne du fichier tabulé est un en-tête, il faut juste ajouter le nom de la colonne supplémentaire "Somme".  
Un fichier d'entrée d'exemple "fichier_tabule.tsv" est disponible dans les données du cours.

Exemple de fichier résultat :
{% highlight tsv %}
Valeur 1	Valeur 2	Somme
5	10	15
3	22	25
{% endhighlight %}

-----------------------

<a name="practice-7"></a>
### Pratique 7: Les dictionnaires :

* Créer un programme python *exo15.py* qui créer un dictionnaire associant à chaque base de l'ADN la chaine "purinique" (C et G) ou "pyrimidinique" (A et T) selon la base, puis qui demande à l'utilisateur (fonction input()) d'entrer une base, et enfin qui affiche si la base entrée par l'utilisateur est purinique ou pyrimidique
{% highlight python %}
# help:
{'G': 'purinique', 'A': 'pyrimidinique', 'C': 'purinique', 'T': 'pyrimidinique'}
{% endhighlight %}

<div class="replie">
    <a class="bouton-deplier">Solution</a>
</div>
<div class="deplie">
    <div class="montexte">script exo15.py
{% highlight python %}
#!/usr/bin/env python3

type_base={'A':'pyrimidinique','T':'pyrimidinique','G':'purinique','C':'purinique'}
print(type_base)
base = input("Donner une base : ")
print(f"c'est une base "{type_base[base]})
{% endhighlight %}
lancer avec {% highlight bash %} python3 exo15.py{% endhighlight %}
</div></div>

* En utilisant un dictionnaire et la fonction in (clef in dictionnaire), créer un programme python *exo16.py* qui stocke dans un dictionnaire le nombre d’occurrences de chaque acide nucléique de la séquence *"AGWPSGGASAGLAILWGASAIMPGALW"*, puis afficher ce dictionnaire.

{% highlight python %}
# Votre programme doit afficher :
{'P': 2, 'I': 2, 'W': 3, 'G': 6, 'L': 3, 'A': 7, 'M': 1, 'S': 3}
{% endhighlight %}

<div class="replie">
    <a class="bouton-deplier">Solution</a>
</div>
<div class="deplie">
    <div class="montexte">script exo16.py
{% highlight python %}
#!/usr/bin/env python3

seq="AGWPSGGASAGLAILWGASAIMPGALW"

dico={}

for base in seq:
	if base not in dico:
		dico[base] = 1
	else:
		dico[base] = dico[base] + 1

print(dico)
{% endhighlight %}
lancer avec {% highlight bash %} python3 exo16.py{% endhighlight %}
</div></div>


* Voila un dictionnaire faisant correspondre à chaque espèce la longueur de son génome :

{% highlight python %}
dico_espece = {'Escherichia coli':3.6,'Homo sapiens':3200,'Saccharomyces cerevisae':12,'Arabidopsis thaliana':125}
{% endhighlight %}

* Créer un programme python *exo17.py*  dans lequel vous créée ce dictionnaire et qui permet d'afficher le nom de l'organisme possédant le plus grand génome.

<div class="replie">
    <a class="bouton-deplier">Solution</a>
</div>
<div class="deplie">
    <div class="montexte">script exo17.py
{% highlight python %}
#!/usr/bin/env python3

dico_espece = {'Escherichia coli':3.6,'Homo sapiens':3200,'Saccharomyces cerevisae':12,'Arabidopsis thaliana':125}

lg_max = 0
for espece,lg in dico_espece.items():
	if lg > lg_max:
		lg_max = lg
		nom = espece
print(f"L'organisme {nom} a le plus grand génome: {lg_max}")

{% endhighlight %}
lancer avec {% highlight bash %} python3 exo17.py{% endhighlight %}
</div></div>

-----------------------

<a name="practice-8"></a>
### Pratique 8: bioPython Seq, SeqRecord et SeqIO:

* Récupérer sur le site du NCBI des séquences nucléiques au format Genbank.
[https://www.ncbi.nlm.nih.gov/nuccore/NR_046237.1?report=genbank&log$=seqview](https://www.ncbi.nlm.nih.gov/nuccore/NR_046237.1?report=genbank&log$=seqview)

* Créer un programme python *exo18.py* qui prend en argument (paramètre) le fichier de séquences au format Genbank et qui crée un nouveau fichier avec les séquences converties au format fasta.

<div class="replie">
    <a class="bouton-deplier">Solution</a>
</div>
<div class="deplie">
    <div class="montexte">script exo18.py
{% highlight python %}
#!/usr/bin/env python3

import sys
from Bio import SeqIO

if len(sys.argv) != 3:
	sys.exit("ERREUR : il faut 2 arguments.")

ficGb = sys.argv[1]
ficNucFasta = sys.argv[2]

nb  = SeqIO.convert(ficGb, 'genbank', ficNucFasta, 'fasta')
print(f"{nuc} séquences ont été converties au format fasta")
{% endhighlight %}
lancer avec {% highlight bash %} python3 exo18.py sequence.gb sequence.fasta{% endhighlight %}
</div></div>

* Créer un programme python *exo19.py* qui prend en argument (paramètre) le fichier de séquences au format Genbank et qui donne la longueur de chaque séquence en écrivant à l'écran pour chaque séquence : "La séquence ... a pour longueur ... "

<div class="replie">
    <a class="bouton-deplier">Solution</a>
</div>
<div class="deplie">
    <div class="montexte">script exo19.py
{% highlight python %}
#!/usr/bin/env python3

import sys
from Bio import SeqIO

if len(sys.argv) != 2:
	sys.exit("ERREUR : il faut 1 arguments.")

ficGb = sys.argv[1]

for maSeq in SeqIO.parse(ficGb, 'genbank'):
	print(f"La séquence {maSeq.id} a pour longueur : {len(maSeq.seq)}")
{% endhighlight %}
lancer avec {% highlight bash %} python3 exo19.py sequence.gb{% endhighlight %}
</div></div>

* Créer un programme python *exo20.py* qui prend en argument (paramètre) le fichier de séquences au format Genbank et qui crée deux nouveaux fichiers, un avec le complément inverse des séquences au format fasta et un avec les séquences traduites en séquences protéiques au format fasta.

<div class="replie">
    <a class="bouton-deplier">Solution</a>
</div>
<div class="deplie">
    <div class="montexte">script exo20.py
{% highlight python %}
#!/usr/bin/env python3

import sys
from Bio import SeqIO

if len(sys.argv) != 4:
	sys.exit("ERREUR : il faut 3 arguments.")

ficGb = sys.argv[1]
ficRevFasta = sys.argv[2]
ficProtFasta = sys.argv[3]

listeSeqRev=[]
#with open(ficRevFasta, "w") as fd:
for maSeq in SeqIO.parse(ficGb, 'genbank'):
	maSeq.seq=maSeq.seq.reverse_complement()
	#fd.write(maSeq.format('fasta'))
	listeSeqRev.append(maSeq)

SeqIO.write(listeSeqRev,ficRevFasta,'fasta')

listeSeqprot=[]
#with open(ficProtFasta, "w") as fd2:
for maSeq in SeqIO.parse(ficGb, 'genbank'):
	maSeq.seq=maSeq.seq.translate()
	#fd2.write(maSeq.format('fasta'))
	listeSeqprot.append(maSeq)

SeqIO.write(listeSeqprot,ficProtFasta,'fasta')
{% endhighlight %}
lancer avec {% highlight bash %} python3 exo20.py sequence.gb sequence_rev_com.fasta proteine.fasta{% endhighlight %}
</div></div>

* Créer un programme python *exo21.py* qui permet de récupérer dans la banque de données Protein du NCBI les séquences du gène SRY (SRY [gene]) de l'homme (Homo sapiens[Orgn]) et qui crée un fichier résultat avec les séquences au format Genbank (option rettype="gb" de la fonction efetch()). Vous limiterez votre recherche aux 10 premières entrées de la banque (option retmax de la fonction esearch()).

<div class="replie">
    <a class="bouton-deplier">Solution</a>
</div>
<div class="deplie">
    <div class="montexte">script exo21.py
{% highlight python %}
#!/usr/bin/env python3

from Bio import Entrez
from Bio import SeqIO
Entrez.email = "arigon@lirmm.fr"
ma_req = Entrez.esearch(db="Protein",retmax=10, term="Homo sapiens[Orgn] AND SRY [gene]")
mon_res = Entrez.read(ma_req)
print(mon_res["Count"])
print(mon_res["IdList"])
ma_req.close()
list_id = mon_res["IdList"]
fic_seq = Entrez.efetch(db="Protein", id=list_id, rettype="gb")
mes_seq = SeqIO.parse(fic_seq,"genbank")
SeqIO.write(mes_seq,"out.fasta","genbank")
fic_seq.close()
{% endhighlight %}
lancer avec {% highlight bash %} python3 exo21.py{% endhighlight %}
</div></div>

* Créer un programme python *exo22.py* qui permet de faire la même chose que le programme précédent mais qui fait en sorte que le nom de la banque de données du NCBI, le nom du gène et de l'organisme, ainsi que le nom de fichier résultat soient donnés en argument à votre programme.

<div class="replie">
    <a class="bouton-deplier">Solution</a>
</div>
<div class="deplie">
    <div class="montexte">script exo22.py
{% highlight python %}
#!/usr/bin/env python3


from Bio import Entrez
from Bio import SeqIO
import sys

if len(sys.argv) != 5:
	sys.exit("ERREUR : il faut exactement 4 arguments : bd, organisme, gene et fichier resultat.")

ma_db = sys.argv[1]
mon_orgn = sys.argv[2]
mon_gene = sys.argv[3]
mon_fic_out = sys.argv[4]

Entrez.email = "arigon@lirmm.fr"
ma_req = Entrez.esearch(db=ma_db,retmax=10, term=mon_orgn+"[ORGN] AND "+mon_gene+"[GENE]")
mon_res = Entrez.read(ma_req)
ma_req.close()
print(mon_res["Count"])
print(mon_res["IdList"])

list_id = mon_res["IdList"]
fic_seq = Entrez.efetch(db="Protein", id=list_id, rettype="gb")
mes_seq = SeqIO.parse(fic_seq,"genbank")
SeqIO.write(mes_seq,mon_fic_out,"genbank")
fic_seq.close()

{% endhighlight %}
lancer avec {% highlight bash %} python3 exo22.py bd organisme gene resultat{% endhighlight %}
</div></div>

* Créer un programme python *exo23.py* qui à partir de 15 séquences d'un gène (donné par l'utilisateur en argument) récupérées sur une banque du NCBI  (donnée par l'utilisateur en argument) affiche à l'écran pour chaque séquence : « séquence nom_sequence de longueur lg_sequence »
Par exemple voilà l'affichage pour les 3 premières séquences récupérées pour le gène SRY dans la banque Protein du NCBI :

<div class="replie">
    <a class="bouton-deplier">Solution</a>
</div>
<div class="deplie">
    <div class="montexte">script exo23.py
{% highlight python %}
#!/usr/bin/env python3

from Bio import Entrez
from Bio import SeqIO
import sys

if len(sys.argv) != 3:
	sys.exit("ERREUR : il faut exactement 4 arguments : bd, organisme, gene et fichier resultat.")

ma_db = sys.argv[1]
mon_gene = sys.argv[2]

Entrez.email = "arigon@lirmm.fr"
ma_req = Entrez.esearch(db=ma_db,retmax=15, term=mon_gene+"[GENE]")
mon_res = Entrez.read(ma_req)
ma_req.close()
print(mon_res["Count"])
print(mon_res["IdList"])

list_id = mon_res["IdList"]
fic_seq = Entrez.efetch(db="Protein", id=list_id, rettype="gb")
mes_seq = SeqIO.parse(fic_seq,"genbank")

for seq in mes_seq:
	print(f"sequence {seq.name} de longeur {len(seq.seq)}")


fic_seq.close()

{% endhighlight %}
lancer avec {% highlight bash %} python3 exo23.py bd organisme gene resultat{% endhighlight %}
</div></div>


-----------------------

### Links
<a name="links"></a>

* Related courses : [Python]({{ site.url }}/python)

-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
