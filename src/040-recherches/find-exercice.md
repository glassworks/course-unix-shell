# Exercice avec find

Dans le projet je vous ai fourni les codes sources de `node.js`, dans `~/node-main`. En utilisant ces codes sources de node :

1. Utilisez la commande `find` afin de créer un fichier vide qui s'appelle `gitkeep` dans tous les dossiers qui ont le mot `util` dans le nom.
2. Vous avez fait une bêtise, le fichier `gitkeep` doit être caché. Utilisez `find` pour corriger votre erreur.
3. Combien de fichiers de type `.js` se trouvent dans ce projet ? Astuce, utilisez la commande `wc` (_w_ord _c_ount) !

## Solutions

<details>

<summary>1. Créer un fichier `gitkeep` avec `find`</summary>

```bash
find . -name "*util*" -type d -exec touch {}/gitkeep \;
find . -name "gitkeep"
```

</details>

<details>

<summary>2. Cacher en masse vos fichiers</summary>

```bash
# Supprimer les fichiers existants
find . -name "gitkeep" -exec rm {} \;
# Recréer le fichier avec le prefix .
find . -name "*util*" -type d -exec touch {}/.gitkeep \;
# Tester
find . -name ".gitkeep"
```

</details>

<details>

<summary>3. Compter le nombre de fichiers</summary>

```bash
find . -name "*.js" | wc -l
303
```

</details>
