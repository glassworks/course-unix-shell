# Redirections des fichiers

On travaille souvent avec les fichiers dans nos manipulations UNIX. On lit les contenus d'un fichier vers le flux `stdin`, et on écrit les résultats sortants sur le flux `stdout` dans le fichiers.

## Redirections : `stdin`

Il est possible de lire un fichier sans passer par la commande `cat`. En effet, il existe un raccourci qui permet de lire les contenus d'un fichier, et les envoyer sur le flux `standard in` :

```bash
grep "hello" < test.txt
```

L’opérateur `<` à la fin d’une commande va lire le fichier vers le `stdin` de la commande

<details>

<summary>Exercice : Reformulez l’opération précédente (compter le nombre de lignes avec "hello") avec une redirection sur le stdin</summary>

```bash
grep "hello" < test.txt | wc -l 
```

Expliquez le résultat du suivant :

```bash
grep "hello" | wc -l < test.txt
```

</details>

## Redirections : `stdout`

Il est possible de rediriger le `stdout` vers un fichier :

```bash
cat test.txt | grep "hello" | wc -l > linecount.txt
```

* L’opérateur `>` redirige le stdout vers un fichier, _en remplaçant le fichier_ !
* L’opérateur `>>` _concatène_ un fichier existant avec de nouvelles lignes.

Essayez !

## Redirections dans les deux sens

On peut combiner les redirections des flux de `stdin` et `stdout` :

```bash
grep "hello" < test.txt | wc -l > linecount.txt
```

## `stdout` vs `stderr`

Parfois un processus va émettre des erreurs. Le flux d’erreurs se redirige vers un autre chaîne :

* `stdout` = la chaîne 1
* `stderr` = la chaîne 2

Essayez le suivant :

```bash
find /proc -name "*hello*" > output.txt
```

Est-ce qu'il y a un résultat dans `output.txt` ?

* Non! Le fichier est vide !

Qu'est-ce qu'on voit dans l'invite de commandes ?

* On voit des erreurs qui ont été emis. J'aurais peut-être préféré que les erreurs soient marqués dans `output.txt`

Pourquoi ?

* Seulement les valeurs dans erreurs sont émises sur le flux `stdout`. Ceci pour assurer une bonne continuation des données dans notre tuyau de traitement. Si un erreur est rencontrée, on l'indique sur un flux différent.

Et si on voulait rediriger le flux d'erreurs dans un autre fichier ?

```bash
find /proc -name "*hello*" > output.txt 2> err.txt
```

En précisant `2>` on dit à l'interprète de prendre la chaîne numéro 2 (`stderr`) et rediriger les contenus dans le fichier `err.txt`.

Par défaut, une redirection sans numéro parle de la chaîne 1 (`stdout`). Ici donc, les résultats sans erreur sont quand même redirigés vers le fichier `output.txt`.

On peut même fusionner les chaînes, surtout si on veut voir les résultats _et_ les erreurs dans le même fichier :

```bash
find /proc -name "*hello*" > output.txt 2>&1
```

Ici, le symbole `2>&1` veut dire qu'on prend les valeurs de la chaîne 2, et les fusionner (`&`) avec la chaîne `1`.

Le `stdout` et `stderr` se trouve tous les deux dans le fichier `output.txt`
