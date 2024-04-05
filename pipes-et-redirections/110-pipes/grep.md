# grep et les expressions régulières

Ayant la possibilité de traiter des données entrants sur le `stdin`, UNIX possède un nombre d'outils puissants pour le traitement et transformation de ses données.

> La philosophie d'UNIX : un outil bien défini pour faire une seule tâche. La puissance se trouve dans le bon enchaînement d'outils pour accomplir une tâche.

## `grep` : _G_et with _R_egular _E_x_p_ression

Un processeur qui filtre le `stdin` et qui émet (sur `stdout`) seulement les lignes qui respectent _l’expression régulière_ passé comme paramètre.

```bash
cat test.txt | grep "hello"
```

Ici, `grep` prend l'expression `"hello"` comme paramètre. C'est l'expression la plus simple : il faut trouver les lignes qui contient le mot `hello` uniquement.

Grep peut lire un fichier directement (au lieu de prendre des données du flux `stdin`) :

```bash
grep [fichier] -e [expression]
```

... ou peut traverser de façon recursive un répertoire :

```bash
grep -r [repertoire] -e [expression]
```

## Les expressions régulières

Une façon de préciser, de manière flexible, un certain nombre de critères pour filtrer un flux de text entrant.

Exemples des _wildcards_ :

* `abc*` : un text qui contient `ab` suivi par 0 ou plusieurs `c`
* `abc+` : un text qui contient `ab` suivi par 1 ou plusieurs `c`
* `abc?` : un text qui contient `ab` suivi par 0 ou 1 `c`
* `a.c` : un text qui commence avec `a` suivi par n’importe quel caractère (un seul) suivi par `c`

Compter le nombre d'itérations dun caractère :

* `abc{2}` : un text qui contient `ab` suivi par 2 fois `c`
* `abc{2,}` : un text qui contient `ab` suivi par au moins 2 fois `c`
* `abc{2,5}` : un text qui contient ab suivi par 2 jusqu’à 5 fois `c` (mais pas plus)

Séquences de caractères :

* `a(bc)*` : un text qui contient `a` suivi par 0 ou plusieurs séquences de `bc`
* `a(b|c)` : un text qui contient `a` suivi par `b` ou `c`

Types de caractère :

* `a\d` : un text qui commence avec `a` suivi par un chiffre (digit simple)

Emplacement des caractères :

* `^abc` : un text qui _commence_ par `abc`
* `abc$` : un text qui _se termine_ par `abc`

Énumérer des options avec `[ ]`:

* `[a-zA-Z]` : un caractère qui est une lettre miniscule ou majuscule

Il y a beaucoup de ressources sur les expressions régulières :

* [Cheat-sheet](https://medium.com/factory-mind/regex-tutorial-a-simple-cheatsheet-by-examples-649dc1c3f285)
* [Outil de conception et test](https://regex101.com)

## Exercice : adresses e-mail

Trouver une expression régulière qui valide le format d’une adresse e-mail de manière suivante :

| E-mail                  | Valide |
| ----------------------- | ------ |
| kevin@nguni.fr          | oui    |
| bob                     |        |
| bob.builder@sponge.com  | oui    |
| thirdy3@456             | oui    |
| bob\&me@thirst.com      |        |
| bob:builder@sponge.com  |        |
| bob(99)@builder.com     |        |
| kevin\_glass@mymail.com | oui    |
| 4uandme@joe.com         | oui    |

<details>

<summary>Liste des emails de test</summary>

```
kevin@nguni.fr
bob
bob.builder@sponge.com
thirdy3@456
bob&me@thirst.com
bob:builder@sponge.com
bob(99)@builder.com
kevin_glass@mymail.com
4uandme@joe.com
```

</details>

Commencez par valider votre expression avec [https://regex101.com](https://regex101.com). Le fichier `emails.txt` existe dans vos dossiers. Est-ce que votre expression régulière fonctionne avec `grep` ?

<details>

<summary>Solution</summary>

Une solution est potentiellement :

```
[a-zA-Z\.0-9_]+@[a-zA-Z\.0-9_]+
```

Attention, par contre, le suivant ne fonctionne pas avec `grep` :

```bash
cat emails.txt | grep "[a-zA-Z\.0-9_]+@[a-zA-Z\.0-9_]+"
```

Pourquoi ? Grep a different parfums, et par défaut la version POSIX ne traite pas des caractères comme `[` et `]`

Extended grep :

```bash
grep -E "[a-zA-Z\.0-9_]+@[a-zA-Z\.0-9_]+"
```

* Support pour les opérateurs `[` et `]`

Perl grep :

```bash
grep -P "^[\w\d\.]+@[\w\d\.]+"
```

* Plus de support pour les opérateurs genre `\w` et `\d`

</details>

## Exercice : Numéro téléphonique

Rédigez une expression régulière qui identifie un numéro de téléphone valide :

* Au moins 10 digits
* Commence par une préfixe valable:
  * Soit un zéro
  * Soit par un `+` suivi par 2 à 4 chiffres (ex. `+33`)
* Suivi par un chiffre qui n'est pas zéro (ex. `6`)
* Suivi par 4 paires de chiffres (ex. `32521467`)

Les numéros `+33632521467`, `0632521467`, `+27489767831` sont valables parmi les options suivantes :

```bash
1432
+33632521467
0632521467
+33249490
+27489767831
1
+334
+33632521467+
```

<details>

<summary>Solution</summary>

Une solution est potentiellement :

```bash
^(((\+)\d{2,4})|[0])[1-9](\d{2}){4}$
```

* Commencez par (`^`) :
  * Soit un plus suivi par 2 à 4 caractères `(\+)\d{2,4}`
  * ou : `|`
  * un zéro : \[0]
* Un seul chiffre (pas zéro): \[1-9]
* 4 paires de 2 chiffres:
  * 2 chiffres: `\d{2}`
  * 2 chiffres fois quatre : `(\d{2}){4}`
* Terminer la ligne par les chiffres et rien d'autre : `$`

</details>

## Exercice : Lookarounds

J'ai un fichier HTML et je veux extraire uniquement la valeur entre les balises :

```html
<html>
  <body>
    <p>This is a paragraph</p>
    <span>This is a span</span>
    <div>Lorem ipsum dolores</div>
  </body>
</html>
```

J'aimerais extraire (avec `grep`) uniquement les textes entre les balises sur chaque ligne :

```
This is a paragraph
This is a span
Lorem ipsum dolores
```

Astuces :

* Regardez les options de `grep` pour voir comment sortir _uniquement_ le texte correspondant et pas toute la ligne qui contient le text
* Vous allez peut-être constater qu'il y a des symboles pas voulus dans le résultat (les balises). Pour les enlever, on peut utiliser les _lookarounds_ ([chercher à comprendre sur cette page](https://learn.microsoft.com/fr-fr/dotnet/standard/base-types/regular-expression-language-quick-reference))

<details>

<summary>Solution</summary>

Au départ on peut dire qu'on va chercher les caractères `>` et `</`. Normalement on éxtrait seulement les lignes avec ces 2 patterns :

```bash
>(.*)<\/
```

Si on essaye avec `grep` :

```bash
hetic@527edcda5f70:~$ cat index.html | grep -P ">(.*)<\/"
    <p>This is a paragraph</p>
    <span>This is a span</span>
    <p>Lorem ipsum dolores</p>
```

On voit qu'on affiche toute la ligne, on veut voir que la partie de texte qui corresponde à notre regex.

Ajoutez l'option `-o` :

```bash
hetic@527edcda5f70:~$ cat index.html | grep -oP ">(.*)<\/"
>This is a paragraph</
>This is a span</
>Lorem ipsum dolores</
```

Mieux ! Par contre, on voit que les balises sont toujours présents. Comment les exclure du résultat ?

Utilisez les _lookarounds_ :

* `(?<=>)` : Le caractère avant `(?<=` doit être un `>`
* `(?=</)` : Les caractères après `?=` doivent être `</`

Donc:

```bash
hetic@527edcda5f70:~$ cat index.html | grep -oP  "(?<=>)(.*)(?=<\/)"
This is a paragraph
This is a span
Lorem ipsum dolores
```

</details>

## Exercice : quotes

Est-ce que vous pourriez extraire correctement le contenu de l'attribute `translate` ? :

```bash
<span class="button active" translate="Ceci est un bouton qui s'appelle \"Click me\"!">
```

Le résultat devrait être :

```bash
Ceci est un bouton qui s'appelle \"Click me\"!
```

Attention, il faut garder les quotes qui sont échappés.

Je ne vous donne pas la solution ici, essayez de trouver tout seul la solution !
