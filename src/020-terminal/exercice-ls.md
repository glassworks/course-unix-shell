# Exercice avec ls

Maintenant vous savez comment lister les dossier et les fichers avec la commande `ls`.

Utiliser le manuel ou l'option `--help` pour les questions suivantes. Essayez de trouver la solution sans regarder la réponse !

1. Les fichiers cachés dans Unix commencent par un `.`. Par exemple le fichier `.bashrc` existe dans votre dossier, mais n'est pas affiché quand on exécute `ls`. Trouvez le moyen d'afficher aussi les fichiers cachés avec `ls`.
2. Quand on fait un **listing** de format longue (`ls -l`), le 5ème colonne nous donne la taille du fichier en nombre d'octets. Ce format n'est pas très lisible pour un humain. Trouvez le moyen d'afficher le listing en utilisant un format plus lisible (en format Ko, Mo ou Go).

## Solutions

<details>

<summary>Afficher les fichiers cachés</summary>

Inclure les fichiers cachés :

```bash
ls -a
```

Inclure les fichiers cachés, dans le format longue :

```bash
ls -la
```

Notez qu'on peut combiner les paramètre après le tiret, par exemple `-la`

</details>

<details>

<summary>Taille en format lisible</summary>

```bash
ls -lh
```

</details>
