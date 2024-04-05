# 🔍 Recherches

La hierarchie globale de répertoires et fichiers peut-être très grande. Il serait donc utile de pouvoir chercher un fichier avec des paramètres particuliers.

Déjà, on peut utiliser la commande `ls` pour chercher dans le répertoire actuel :

```bash
# Lister tous les fichiers qui commencent par "int"
ls int*
```

L'asterisk (`*`) represente un **caractère de remplacement** ou _**wildcard**_, qui veut dire qu'on accepte tous les fichiers malgré ce qui suit les lettres "int" dans son nom.

On peut utiliser le _wildcard_ de plusieurs façons :

```bash
# Le nom du fichier se termine par du texte :
ls *.js

# Le nom de fichier contient du texte :
ls *ME*
```

Et si on voulait chercher un fichier, mais _on ne sait pas dans quel dossier il se trouve_ ? Est-ce que `ls` est suffisant ? Regarder sa documentation pour essayer de trouver une solution.
