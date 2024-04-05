# sed : chercher et remplacer

Souvent on aimerait chercher une chaîne de caractères et les remplacer par autre chose dans le flux sortant.

L'outil `sed` (_s_tream _ed_itor) est très utile pour cela.

Par exemple, pour remplace tous les mots `hello` par `goodbye` :

```bash
cat test.txt | sed 's/hello/goodbye/'
```

Avec `sed`, on structure notre paramètre entrant avec un opérateur suivi par les paramètres. Ici :

* `s` : veut dire _s_ubstitution (chercher et remplacer). On attend 2 paramtètres suivants, séparés par les slash `/`
* `hello` : veut dire qu'on cherche le mot `hello`
* `goodbye` : le texte à utiliser pour remplacer `hello`

Lisez plus sur la commande `sed` :

* [ici](https://www.geeksforgeeks.org/sed-command-in-linux-unix-with-examples/)
* `man sed`

<details>

<summary>Analysez les résultats de `sed` ci-dessus. Est-ce que toutes les instances de `hello` sont bien remplacées ?</summary>

Indiquez qu'il faut remplacer **toutes** les instances, avec le flag `g` (pour  **g**lobal) de chaque ligne, sinon, on remplace seulement la première trouvée :

```
cat test.txt | sed 's/hello/goodbye/g'
```

</details>

<details>

<summary>Comment supprimer les lignes contenant une instance de texte ?</summary>

Utiliser l'instruction \`d\` (**d**elete) &#x20;

```
cat test.txt | sed '/hello/d'
```



</details>

## Exercice

Pour créer vos comptes sur mon serveur, j'ai du lire un fichier contenant vos adresses email, et :

* Les filtrer : seulement les adresses e-mail valables sont prises. Les lignes vides ou les e-mails non-valables sont ignorés
* Les transformer :
  * enlever du blanc avant et après l'adresse
  * convertir le texte en miniscule uniquement
  * remplacer l'arobase `@` par un point `.`

Un exemple d'un fichier de ce type se trouve dans `email-dirty.txt`.

Construisez, en une ligne, un enchaînement de commandes qui traite ce fichier et qui sort sur `stdout` la liste d'emails propres.

> Astuce : consulter les [mots-clés spéciaux de la norme POSIX](https://www.gnu.org/software/sed/manual/html\_node/Character-Classes-and-Bracket-Expressions.html). Vous pouvez aussi chercher sur Google !

<details>

<summary>Solution</summary>

```bash
sed 's/[[:blank:]]//g' < emails-dirty.txt | sed '/^$/d' |  grep -P "^[\w\d\.]+@[\w\d\.]+" | sed 's/[[:upper:]]/\L&/g' | sed 's/@/\./g'
```

* `sed 's/[[:blank:]]//g'` : enlever tous les blancs du flux
* `sed '/^$/d'`: enlever les lignes vides (rien entre le début `^` et la fin `$`)
* `grep -P "^[\w\d\.]+@[\w\d\.]+"` : filtrer uniquement les adresses e-mail valables
* `sed 's/[[:upper:]]/\L&/g'` : convertir les majuscules en miniscule
* `sed 's/@/\./g'` : remplacer le @ par .

</details>
