# Fonctions

Il est possible d'encapsuler de la logique dans les fonctions avec le mot clé `function`.

```bash
function translate() {
  local GIBBERISH=$(echo $1 | sed "s/[aeiou]/iggedu/g")
  echo $GIBBERISH
}


translate "Ceci est un test"
translate "Une autre valeur"
```

Dans l'exemple, on a crée une fonction qui s'appelle `translate`.

Cette fonction va prendre un paramètre (qu'on récupère via la variable `$1`, et remplacer toutes le voyelles par une phrase `iggedu`).

Le mot clé `local` précise que la variable `GIBBERISH` n'existera uniquement à l'intérieur de la fonction, et ne peut pas être utilisé en dehors de la fonction.

On retourne les valeurs d'une fonction sur le `stdout`, d'où le `echo` à la fin de la fonction.

En bas du script, on invoke la fonction comme n'importe quelle fonction : en citant son nom suivi par des paramètres.

## Exercice

En utilisant un script shell, créez un outil qui, en utilisant une fonction, calcul Pythagore. Le script prend 2 numéros comme paramètres : disons x et y

Emettez sur le stdout, la longueur de l’hypoténuse si x et y sont les longueurs des 2 cotés d’un triangle droit

Astuce : regardez la commande `bc` pour vous aider

<details>

<summary>Solution</summary>

La commande `bc` (bash calculator), permet de calculer les valeurs decimals et plus grandes que possibles par `bash` nativement. Elle fonction par interpreter une expression sur le `stdin`.

```bash
#!/bin/bash

function pythagore() {
 local x=$1
 local y=$2
 local hypotenuse=$( echo "sqrt($x^2 + $y^2)" | bc -l )
 echo $hypotenuse
}

echo $(pythagore $1 $2)
```

</details>
