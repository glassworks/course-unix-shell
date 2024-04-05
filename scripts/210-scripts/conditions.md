# Conditions

Dans UNIX, chaque commande émet un statut en sortant :

* Une valeur de 0 veut dire que la commande est terminé avec succès
* Une valeur supérieur à 0 veut dire une erreur

On peut à tout moment récupérer le statut de la dernier commande effectuée avec la variable `$?` :

```bash
echo $?
```

Par exemple :

```bash
hetic@527edcda5f70:~$ echo "Hello world"
Hello world
hetic@527edcda5f70:~$ echo $?
0
hetic@527edcda5f70:~$ cat fichernonexistant
cat: fichernonexistant: Aucun fichier ou dossier de ce type
hetic@527edcda5f70:~$ echo $?
1
```

Dans l'exemple, on voit le statut de 0 après la commande `echo`. En revanche, la commande `cat` a crée une erreur, et donc il y avait 1 dans `$?`.

On pourrait donc faire de la logique dans nos scripts basé sur le statut des commandes.

Une commande spéciale qui s'appelle `test` permet d'évaluer des conditions, et émettre le bon statut selon le résultat de l'évaluation :

* Si la condition passe, `test` se termine avec succès en mettant 0 dans la variable `$?`
* Si la condition ne passe pas, `test` se termine avec erreur, en mettant 1 dans la variable `$?`

Essayez vous-même :

```bash
# Est-ce que 55 est inférieur à (*less than*) 80 ?  
test 55 -lt 80
echo $?

# Est-ce que 55 est supérieur à (*greater than*) 100 ?
test 55 -gt 100
echo $?
```

Avec `test` on peut donc formuler une condition :

```bash
if test 55 -lt 80; then
  echo "Oui 55 est bien inférieure à 80"
else 
  echo "Ueh, 55 est supérieur à 80 ??"
fi
```

La formulation de la commande `if` et donc :

```bash

if [commande]; then
  # Les instructions à effectuer si la command émet 0 comme statut de sortie
else
  # Les instructions à effectuer si la command émet >0 comme statut de sortie
fi
```

> Attention au point-virgule après la commande, et les mots-clés `then` et `fi` !

## Options de `test`

La commande `test` permet de tester un grand nombre de conditions :

| Option                                                | Explication                                                               |
| ----------------------------------------------------- | ------------------------------------------------------------------------- |
| _Conditions numériques_                               |                                                                           |
| `test $A -eq $B`                                      | Tester que la valeur (numérique) dans `$A` est égale à `$B`               |
| `test $A -ne $B`                                      | Tester que la valeur (numérique) dans `$A` n'est pas égale à `$B`         |
| `test $A -gt $B`                                      | Tester que la valeur (numérique) dans `$A` est supérieure à `$B`          |
| `test $A -ge $B`                                      | Tester que la valeur (numérique) dans `$A` est supérieure ou égale à `$B` |
| `test $A -lt $B`                                      | Tester que la valeur (numérique) dans `$A` est inférieure à `$B`          |
| `test $A -le $B`                                      | Tester que la valeur (numérique) dans `$A` est inférieure ou égale à `$B` |
| _Conditions avec les chaînes de caractères (strings)_ |                                                                           |
| `test $A = $B`                                        | Tester que le string dans `$A` est égale au string dans `$B`              |
| `test $A != $B`                                       | Tester que le string dans `$A` n'est pas égale au string dans `$B`        |
| `test -z $A`                                          | Tester que la variable `$A` est vide                                      |
| `test -n $A`                                          | Tester que la variable `$A` contient au moins 1 caractère (non-vide)      |
| _Conditions des fichiers_                             |                                                                           |
| `test -e $A`                                          | Tester que le fichier ou le répertoire qui est précisé dans $A existe     |
| `test -f $A`                                          | Tester que le fichier qui est précisé dans $A existe                      |
| `test -d $A`                                          | Tester que le répertoire qui est précisé dans $A existe                   |

A tout moment, on peut inverser la logique avec le symbole `!`.

Par exemple, si un fichier de nom `abc.txt` n'existe pas :

```bash
if test ! -f abc.txt; then
  echo "Le fichier n'existe pas"
fi
```

## Formulation de `test` avec les crochets

Une autre formulation de la commande `test` existe, qui est parfois plus lisible pour un développeur, en utilisant les crochets `[`et `]` :

```bash
if [ ! -f abc.txt ]; then
  echo "Le fichier n'existe pas"
fi

A=1992
B=$(date +%Y)
if [ $B -gt $A ]; then
  echo "Après la sorti de Jurassic Park!"
else
  echo "Avant la sorti de Jurassic Park!"
fi
```

## Exercice

Rédigez un script `bouncer.sh` qui aide un contrôleur d'une boîte de nuit à calculer l'age d'entrée des visiteurs.

Si un visiteur à moins que 23 ans, il/elle ne pourra pas entrer.

Le script doit demander l'année de naissance du visiteur, et émettre :

* Bienvenue ! Amusez vous bien !
* Non-autorisé, il faut attendre X ans avant de rentrer.

<details>

<summary>Solution</summary>

```bash
#!/bin/bash

# Définir l'age d'entrée
ENTRYAGE=23

echo "Votre année de naissance ?"
read BIRTHYEAR

# date +%Y donne uniquement l'année actuelle
# On utilise la formulation $( ... ) pour récupérer le résultat de cette commande
YEAR=$(date +%Y)

# On utilise la formulation $(( ... )) pour effectuer le calcul
AGE=$(($YEAR - $BIRTHYEAR))

if [ $AGE -ge $ENTRYAGE ]; then
  echo "Bienvenue ! Amusez vous bien !"
else
  DIFF=$(( $ENTRYAGE - $AGE ))``
  echo "Non-autorisé, il faut attendre $DIFF ans avant de rentrer."
fi

```

</details>
