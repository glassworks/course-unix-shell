# find

L'outil `find` est très puissant dans Unix, et nous permet de chercher des fichiers ou répertoires :

* par son nom
* par son contenu
* ... et effectuer des actions sur les résultats.

Le syntaxe simple de `find` est le suivant :

```bash
find [repertoire de recherche] –[type de recherche] [critères de recherche]
```

Par exemple, pour chercher tous les fichiers (à partir du répertoire actuel) avec le nom qui commence par utils :

```bash
find . -name "utils.*"

# . = commencer dans le répertoire actuel
# -name = on va chercher dans le nom du fichier
# "utils.*" il faut commencer par le mot "utils." avec n'importe quelle extension (representé par l'asterisk *)
```

Pour trouver les répertoires avec "util" dans le nom :

```bash
find . -name "*util*" -type d
```

Rappelez, vous pouvez apprendre plus de paramètres avec `man find`. Ou bien chercher en-ligne, par exemple, [ce résumé](https://alvinalexander.com/unix/edu/examples/find.shtml)

## Effectuer une action sur les fichiers trouvés

`find` permet non-seulement de chercher des fichiers, mais aussi d’en faire quelque chose :

```bash
find . -name [critères] -exec [commande à executer] \;

## Attention ! la commande doit terminer par \;
```

Exemple, lister les répertoires, et afficher leur nom avec un morceau de texte personnalisé devant :

```bash
hetic@eabaf4e7983c:~$ find . -name "*util*" -type d -exec echo "Voici un fichier : {}" \;
Voici un fichier : ./node-main/lib/internal/util
Voici un fichier : ./node-main/lib/util
```

Ici, `find` exécute la commande `echo` pour chaque répertoire trouvé, et affiche le resultat `Voici un fichier :  {}`

Les accolades `{}` sont remplacés par chaque nom de répertoire.

Bien sur il serait plus intéressant d'utiliser des commandes dans `exec` qui sont plus utiles, comme, change le nom du fichier, le supprimer, le modifier etc.
