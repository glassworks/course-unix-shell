# awk

AWK est une commande très puissant pour le traitement des commandes :

* il fonctionne en tant que commande qui agit sur `stdin`
* il fonctionne en tant qu'interprète comme `bash`

C'est un language de programmation pour le shell qui peut-être très puissant. Mais il faut d'abord l'étudier :

* [awk](https://www.grymoire.com/Unix/Awk.html)
* [cheat-sheet](https://www.shortcutfoo.com/app/dojos/awk/cheatsheet)

## `awk` en bref

J'utilise `awk` typiquement dans l'analyse de logs, parce qu'il y a le moyen d'extraire facilement _des colonnes_ précis, ainsi qu'effectuer des _opérations mathématiques_ (comme l'addition) sur l'ensemble des lignes.

Par exemple, regardez le fichier `columnes.txt` :

```bash
hetic@eabaf4e7983c:~$ cat columns.txt 
1 Hello Kevin 40
2 Goodbye Robert 22
3 Morning Glass 34
4 Evening Matthew 45
```

On voit qu'il y a 4 colonnes. Si je voulais extraire seulement le 3ème colonne :

```bash
cat columns.txt | awk '{ print $3 }'
```

Ce qui se trouve entre les accolades `{}` est le language de programmation `awk` dont la commande `print` est définie.

Si je voulais trouver la somme de la dernière colonne :

```bash
cat columns.txt | awk '{ s+=$4 } END { print s }'
```

Rien que cette fonctionnalité est très utile dans la manipulation des journaux, par exemple.

## Exercice avec `awk`

Est-ce que vous pouvez trouver la totale de la colonne 9 (« value ») du fichier .csv [qui si trouve ici](https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2020-financial-year-provisional/Download-data/annual-enterprise-survey-2020-financial-year-provisional-csv.csv) ?

<details>

<summary>Solution</summary>

D'abord, téléchargez le fichier :&#x20;

```
bash wget https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2020-financial-year-provisional/Download-data/annual-enterprise-survey-2020-financial-year-provisional-csv.csv
```

Ensuite regardez la colonne 9 :

```bash
head -n 5 annual-enterprise-survey-2020-financial-year-provisional-csv.csv | awk '{ print $9 }'
```

Oups ! Ce fichier est délimité par une virgule, et pas une espace ! Comment faire ?

Précisez le délimiteur avec le paramètre `-F` :

```bash
head -n 5 annual-enterprise-survey-2020-financial-year-provisional-csv.csv | awk -F',' '{ print $9 }'
```

Oups, ça ne fonctionne toujours pas. Parce que certaines colonnes contient des virgules au sein des guillemets.

Il me semble que `awk` tout seul ne sera pas suffisant pour ce problème. On devrait utiliser gnu-awk qui nous donne plus d'options :

```bash
sudo apt install gawk
```

Selon [quelques recherches web](https://www.gnu.org/software/gawk/manual/html\_node/Splitting-By-Content.html), on pourrait préciser plus précisément la forme de chaque colonne :

```bash
head -n 5 annual-enterprise-survey-2020-financial-year-provisional-csv.csv | gawk -v FPAT='([^,]*)|("[^"]+")'  '{ print $9 }'
```

Maintenant on a les bonnes valeurs, sauf ils sont lues en tant que string et ne sont pas additionnables. Il faut enlever les guillemets, et transformer la virgule en point :

```bash
head -n 5 annual-enterprise-survey-2020-financial-year-provisional-csv.csv | gawk -v FPAT='([^,]*)|("[^"]+")'  '{ gsub("\"","", $9);sub(",", ".", $9);print $9; s+=$9 } END { print s }'

# gsub("\"","", $9) : remplacer les " par rien dans la colonne 9
# sub(",", ".", $9) : remplacer la , par un point dans la colonne 9
# print $9 : afficher pour debogguer
# s+=$9 : faire l'addition
```

Enfin, on peut trouver la somme de la colonne 9 :

```bash
cat annual-enterprise-survey-2020-financial-year-provisional-csv.csv | gawk -v FPAT='([^,]*)|("[^"]+")'  '{ gsub("\"","", $9);sub(",", ".", $9); s+=$9 } END { print s }'
```

</details>
