# Variables

Dans le shell UNIX, on peut à tout moment préciser des variables qui existeront dans _l'environnement_ : c'est à dire, dans la séance actuellement ouverte.

Une variable se crée en faisant une simple affectation :

```bash
# Créer une variable qui s'appelle NAME et affecter la valeur Kevin dedans
NAME=Kevin
```

On peut à tout moment afficher les contenus d'une variable :

```bash
echo $NAME
```

Notez qu'on faire rappeler une variable en ajoutant un dollar `$` devant son nom.

> Attention : Quand on crée une variable, il n'y a pas d'espace entre le nom, l'égal, et la valeur :
>
> ```bash
> # Erreur
> SURNAME = Glass
>
> # Pas d'erreur
> SURNAME=Glass 
> ```

On peut composer des valeurs plus complexe :

```bash
echo "Hello $NAME, welcome to the Unix Shell course"
```

## Variables d'environnement

Une variable persiste pendant la durée de vie de notre shell. Si on quitte le shell (soit en fermant la fenêtre, soit en tapant `exit`), les variables seront oubliées.

> Testez vous même !
>
> * Déclarez une variable comme `NAME=Kevin` dans votre shell
> * Ensuite montrez la variable avec `echo $NAME`.
> * Fermez la fenêtre, et ré-ouvrez une nouvelle.
> * Refaites `echo $NAME`. Vous verrez que la variable n'existe plus !

Pendant vos carrières vous allez entendre parler des _variables d'environnement_. C'est à dire, les variables qui sont définies dans le shell, puis qui sont utilisées au sein de processus qui tournent dans ce shell là.

Testons la création et utilisant des variables d'environnement !

Commencez par en déclarer une :

```bash
NAME=Kevin
```

Ensuite, nous allons créer un script qui utilise cette variable, par exemple, dans `greeting.sh` :

```bash
#!/bin/bash

echo "Hello $NAME, how are you today ?"
```

Si vous exécutez ce script avec `source`, vous verrez que la variable `$NAME` a été remplacé par la valeur que vous avez définie dans le shall :

```bash
hetic@527edcda5f70:~$ source greeting.sh 
Hello Kevin, how are you today ?
```

Cela veut dire qu'on peut personnaliser le comportement de notre script juste en changeant la variable dans le shell, et sans devoir modifier le script même :

```bash
hetic@527edcda5f70:~$ NAME=Adrien
hetic@527edcda5f70:~$ source greeting.sh 
Hello Adrien, how are you today ?
```

## Variables et un _child process_

En revanche, un _child process_ de notre shell ne peut pas encore utiliser nos variables.

Essayez de lancer le script précédent en tant que _child process_ :

```bash
hetic@527edcda5f70:~$ bash greeting.sh 
Hello , how are you today ?
```

Oups ! Le nom défini dans `$NAME` est vide ! C'est parce que cette variable n'est pas encore visible par notre _child process_.

Pour le rendre visible on utilise la commande `export` :

```bash
export NAME=Kevin
```

Réessayez de tourner notre script :

```bash
hetic@527edcda5f70:~$ bash greeting.sh
Hello Kevin, how are you today ?
```

La variable a été reconnu !

> Quelle est la différence ?
>
> * Avec `source` : lancer un script avec `source` va juste lire le fichier en utilisant l'interprète actuel, pour qui les variables déclarées (sans `export`) sont déjà visibles
> * Quand on lance un script avec `bash` ou un script exécutable (ex. `./greeting.sh`), _un nouveau child process est crée_ ! Les variables définies dans la parent ne sont pas visibles par enfant tant que le mot `export` n'est pas utilisé.

On peut visionner toutes les variables définies par `export` juste en tapant `export` :

```bash
hetic@527edcda5f70:~$ export
declare -x BROWSER="/vscode/vscode-server/bin/linux-x64/e8a3071ea4344d9d48ef8a4df2c097372b0c5161/bin/helpers/browser.sh"
declare -x COLORTERM="truecolor"
declare -x HOME="/home/hetic"
declare -x HOSTNAME="527edcda5f70"
declare -x LANG="fr_FR.UTF-8"
declare -x LANGUAGE="fr_FR:fr"
declare -x LC_ALL="fr_FR.UTF-8"
declare -x NAME="Kevin"
declare -x OLDPWD
...
```

## Persistance des variables d'environnement

On a déjà vu qu'une variable d'environnement ne persiste pas si on ferme le shell.

Pour assurer la persistance d'une variable, il faudrait les définir dans un script qui sera automatiquement exécuter à la création de notre shell.

Avec `bash`, le fichier `~/.bashrc` est exécuté (s'il existe) a chaque création d'un nouveau shell.

Il faudrait donc définir nos variables persistantes dans ce fichier :

```bash
nano ~/.bashrc
```

## Les quotes, apostrophes, et les variables

On a déjà vu qu'on peut afficher les contenus d'une variable avec `echo` :

```bash
NAME=Kevin
echo $NAME
```

Essayez avec votre nom entier !

```bash
hetic@527edcda5f70:~$ NAME=Kevin Robert Glass
bash: Robert : commande introuvable
```

Oups, il y a eu un problème ! Le faite d'avoir des espaces dans ma variable a crée une erreur, parce que l'interprète considère des espaces comme séparateur de commandes et ses paramètres.

Il faut indiquer que la phrase est une valeur _unique_ en l'entourant par les quotes :

```bash
NAME="Kevin Robert Glass"
```

On pourra bien sur combiner un ensemble de variables :

```bash
NAME="Kevin"
SURNAME="Glass"
FULLNAME="$NAME $SURNAME"
echo $FULLNAME
```

Vous avez peut-être remarqué que les quotes ont un sens particulier : ils ne sont pas inclus dans la valeur de la variables. Comment faire si je veut inclure un quotes dans la valeur ?

Il faudrait _échapper_ les quotes avec un anti-slash `\` :

```bash
PHRASE="Kevin dit: \"Bonjour à tous\""
echo $PHRASE
```

Il est possible d'utiliser aussi des apostrophes simples pour préciser une valeur contiguë :

```bash
PHRASE='Kevin dit: "Bonjour à tous"'
echo $PHRASE
```

Quelle est la différence entre les quotes et les apostrophes alors ?

* _Quotes_ : indique une valeur contiguë en laissant la possibilité d'interpreter des variables et/ou symboles spéciales à l'intérieure des quotes
* Apostrophe : aucune interpretation n'est fait. La valeur est recopié à l'identique.

Imaginons qu'on veut remplace `Kevin` dans la phrases par une variable `$NAME` :

```bash
hetic@527edcda5f70:~$ PHRASE='$NAME dit: "Bonjour à tous"'
hetic@527edcda5f70:~$ echo $PHRASE
$NAME dit: "Bonjour à tous"
```

Oups ! La variable `$NAME` n'est pas interprété comme variable ! C'est parce qu'on a entouré la phrase par des apostrophes simples, avec le résultat que tout est recopié à la lettre, y compris `$NAME`.

Si on remplace les apostrophes par des quotes, on devrait donc échapper des quotes à l'intérieur, mais notre variable est bien interprété :

```bash
hetic@527edcda5f70:~$ PHRASE="$NAME dit: \"Bonjour à tous\""
hetic@527edcda5f70:~$ echo $PHRASE
Kevin dit: "Bonjour à tous"
```

> A retenir :&#x20;
>
> * _Quotes_ : si on veut que le contenu soit interprété&#x20;
> * _Apostrophes_ : si on veut que le contenu soit recopié à l'identique sans interpretation

## Input

Il est possible de lire de valeurs sur le `stdin` avec la commande `read`.

Par exemple, le script suivant demande le nom de la personne :

```bash
#!/bin/bash

echo "Quel est votre prénom ?"
read NAME 

echo "Bonjour $NAME ! Bienvenue !"
```

Quand on lance le script, il demande le nom de l'utilisateur.

J'ai dit que la commande `read` va lire des données sur le flux `stdin`. Logiquement, on pourrait aussi renvoyer des données via un pipe :

```bash
hetic@527edcda5f70:~$ echo "Bob" | source name.sh 
Quel est votre prénom ?
Bonjour Bob ! Bienvenue !
```

Remarquez que dans l'exemple dessus, la ligne `read` s'est fait tout seule (sans s'arrête attendre le nom), parce qu'il y avait déjà des données qui attendait sur le `stdin`, grâce au pipe !

## Paramètres

On peut aussi renvoyer des données dans un script à travers des paramètres qu'on précise dans l'invite de commandes, par exemple, si je voulais plutôt préciser le nom de la personne via un paramètre (et ne pas demander à l'entrer), je pourrais formuler mon script comme le suivant :

```bash
#!/bin/bash

echo "Bonjour $1 ! Bienvenue !"
```

La variable `$1` est une variable spéciale qui précise d'utiliser la 1ère valeur après le nom du script :

```bash
hetic@527edcda5f70:~$ source name.sh Kevin
Bonjour Kevin ! Bienvenue !
```

Dans l'exemple, la valeur `Kevin` est automatiquement affectée à la variable `$1`.

Il y a d'autres variables spéciales :

* `$1` : la première valeur après le nom du script
* `$2` : la deuxième valeur après le nom du script
* `$3` : la troisième valeur après le nom du script (etc.)
* `$#` : le nombre de paramètres en total
* `$*` : la liste de paramètres
* `$@` : une array avec tous les arguments dedans

## Calculs avec les variables

Il est possible d'effectuer des opérations mathématiques avec `bash` :

```bash
A=10
B=5
echo $(($A + $B))
```

En effet la formulation `$(( ... ))` dit à l'interprète de calculer l'expression mathématique à l'intérieure.

> Et si on faisait juste :
>
> ```bash
> echo $A + $B
> ```
>
> Vous pouvez expliquer la différence ?

## Affecter le résultat d'une commande à une variable

Parfois une commande va écrire un résultat sur le flux `stdout`, et on aimerait utiliser cette valeur dans un script à nous.

Par exemple, la commande suivante va emettre le nom de l'utilisateur actuel sur le `stdout`:

```bash
id -u -n
```

Par exemple :

```bash
hetic@527edcda5f70:~$ id -u -n
hetic
```

Je peux affecter cette valeur dans une variable au lieu de l'émettre sur `stdout` :

```bash
UTILISATEUR=$( id -u -n )
```

La formulation `$( ... )` dit l'interprète de d'abord exécuter les instructions à l'intérieur des parenthèses, et affecter ou utiliser le résultat.

> J'aurais pu aussi utiliser les _backticks_ pour accomplir la même chose :
>
> ```bash
> UTILISATEUR=`id -u -n`
> ```

## Exercice : calculatrice d'age

Ecrivez un script qui s'appelle `age.sh` qui lit, via le `stdin`, le nom de l'utilisateur, et son année de naissance.

Le script devrait calculer l'age de l'utilisateur, et afficher le message suivant : `Bonjour [nom], vous avez [age] ans`.

> Astuce : La commande `date` retourne la date actuelle, et permet de sortir seulement un seul composant de la date sur le `stdout`.

<details>

<summary>Solution</summary>

```bash
#!/bin/bash

echo "Votre prénom ?"
read NAME

echo "Votre année de naissance ?"
read BIRTHYEAR

# date +%Y donne uniquement l'année actuelle
# On utilise la formulation $( ... ) pour récupérer le résultat de cette commande
YEAR=$(date +%Y)

# On utilise la formulation $(( ... )) pour effectuer le calcul
AGE=$(($YEAR - $BIRTHYEAR))

echo "Bonjour $NAME, vous avez $AGE ans" 
```

</details>
