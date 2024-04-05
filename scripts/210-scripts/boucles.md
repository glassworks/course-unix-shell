# Boucles

Il est possible d'itérer sur les valeurs, comme dans n'importe quel autre language.

## Boucle `for in`

```bash
#!/bin/bash

NAMES="Kevin Robert Glass"

for NAME in $NAMES; do
  echo $NAME
done
```

Dans l'exemple dessus, on itère sur chaque élément de la variable `$NAMES`. A chaque itération on affecte l'élément en cours à la variable temporaire `$NAME`, qu'on peut utiliser au dans le bloque entre `do` et `done`.

Ceci est très utile pour la construction de nos scripts.

Par exemple, si j'ai un nombre de paramètres inconnu, je pourrais itérer sur chaque paramètre :

```bash
#!/bin/bash

# Rappelez que la variable $@ contient un array de valeurs passées comme paramètre

for PARAM in $@; do
  echo $PARAM
done
```

Si on exécute ce script on aura le suivant :

```bash
hetic@527edcda5f70:~$ source names.sh this is a parameter
this
is
a
parameter
```

Souvenez vous que la commande `ls` ne retourne que la liste des fichiers et répertoires, sans plus d'information, et en omettant les fichiers cachés ? Ce n'est pas si mal, surtout si on veut itérer sur les fichiers d'un dossier et en faire quelque chose :

```bash
#!/bin/bash

FILES=$(ls)

for FILE in $FILES; do
  echo "Updating timestamp of $FILE"
  touch $FILE
done
```

## Boucle `while`

La boucle `for` ne permet pas de tester une condition quelconque, avec la commande `test`.

Parfois, ceci est nécessaire, et serait possible avec la condition `while`.

```bash
#!/bin/bash

COUNT=0

# Notez que la condition s'exprime comme pour une condition
while [ $COUNT -lt 5 ]; do
  echo "This is iteration $COUNT"

  # N'oubliez pas de mettre à jour les variables de la condition
  COUNT=$(($COUNT + 1))
done
```

## Exercice

Créez un mini-jeu où le script choisit une valeur aléatoirement. L'utilisateur doit deviner la valeur. Le script doit aider l'utilisateur à trouver la bonne valeur :

* S'il devine une valeur trop grande, le script doit l'indiquer
* S'il devine une valeur trop petite, le script doit l'indiquer

Le jeu se termine quand on devine la bonne valeur. Le score est le nombre de tentatives avant de deviner la bonne valeur.

<details>

<summary>Solution</summary>

```bash
#!/bin/bash

# Calculer une valeur entre 1 et 50
MAX=50
NUMBER=$(( $RANDOM * $MAX / 32767 ))

echo "Devinez la valeur que j'ai en tête, elle serait entre 1 et $MAX" 

GUESS=-1
TRIES=0

while [ $GUESS -ne $NUMBER ]; do
  read GUESS
  if [ $GUESS -lt $NUMBER ]; then
    echo "Trop petit !"
  elif [ $GUESS -gt $NUMBER ]; then
    echo "Trop grand !"
  fi
  TRIES=$(($TRIES + 1))
done

echo "Bravo,  valeur trouvée en $TRIES tentatives !"

```

</details>
