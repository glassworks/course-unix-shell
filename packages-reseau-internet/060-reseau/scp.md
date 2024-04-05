# SCP : Transférer des fichiers

(prérequis : [SSH](broken-reference))

On peut émettre des commandes sur la machine distant, et même télécharger des fichiers du web.

Par contre, comment transférer un fichier de ma machine vers la machine distante ? Ou de la machine distante vers ma machine ?

Il y a une commande qui s'appelle `scp` (_s_ecure _c_o_p_y), qui utilise le protocole `ssh` afin de transférer (de façon sécurisée) des fichiers entre deux machines :

```bash
scp [source] [destination]
```

La source et/ou la destination peut être la machine locale ou bien la machine distante.

Sur la machine distante, que ce soit la source ou la destination, on doit préciser d'abord les coordonnées de connexion suivi par l'emplacement du fichier : &#x20;

```
[identifiant]@[adresse IP ou nom d'hôte]:/chemin/du/fichier
```

Par exemple, pour transférer un fichier qui s'appelle `test.txt` de la machine locale (dans le répertoire actuel) vers mon serveur distante, et à mettre dans le dossier maison :

```bash
scp ./test.txt identifiant@unixshell.hetic.glassworks.tech:/home/identifiant
```

Notez que l'emplacement finale dans l'arborescence distante est précisé après l'URL et le deux-points.

On peut également copier le fichier directement dans le dossier _home :_

```bash
scp ./test.txt identifiant@unixshell.hetic.glassworks.tech:~
```

Pour transférer un fichier à `/tmp/logs.txt` de la machine distante ver ma machine locale :

```bash
scp identifiant@unixshell.hetic.glassworks.tech:/tmp/logs.txt .
```

A noter : la commande `scp` utilise par défaut la clé privée qui se trouve dans `~/.ssh/id_rsa` pour connecter à la machine distante, comme fait `ssh`. Si on veut préciser une autre clé, on utilise le même paramètre `-i` : &#x20;

```bash
scp -i chemin/vers/la/clé/à/utiliser identifiant@unixshell.hetic.glassworks.tech:~
```

### Exercice

* transférez le fichier `node-main/AUTHORS` de votre machine locale vers votre espace sur mon serveur.
* modifiez le fichier sur la machine distante, en ajoutant vos coordonnées à la liste
* transférez le fichier vers votre machine locale, et vérifiez que vous voyez la modification en locale
