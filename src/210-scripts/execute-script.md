# Rédiger et exécuter un script

D'abord, un script est juste un fichier texte. On en crée un avec, par exemple `nano` :

```bash
nano world.sh
```

On commence notre script avec un *shebang*, qui est une ligne de format spécial qui indique l'interprète à utiliser par défaut quand on exécute ce script :

```bash
#!/bin/bash

echo "Hello world"
```

Le *shebang* prend la forme :

```bash
#![chemin vers l'interprète]
```

Par exemple, l'interprète `bash` existe à `/bin/bash`.

Ensuite, on rédige les commandes qu'on connait déjà pour UNIX et `bash`.

## Lancer un script

Pour exécuter notre script, on quitte l'éditeur de texte. Il y a plusieurs façons de l'exécuter.

* Avec la commande `source` :

```bash
# Avec la commande "source"
source world.sh

# Utiliser un point à la place se source (. est un alias pour source)
. world.sh
```

> La commande `source` passe les contenus de notre script à *l'interprète actuel* pour exécution.

* En lançant un nouvel interprète spécifique :

```bash
# Interpreter le script avec l'interprète bash
bash world.sh

# Alternatif 
/bin/bash world.sh

# Ou bien, lancer le script avec sh
sh world.sh
```

> Lancer notre script avec un interprète aura l'effet de lancer un nouvel interprète comme *processus enfant*. En anglais on dit qu'on  *spawn a child process*. [Vous vous souvenez comment on a créer un nouvel interprète dans le premier ?](../020-terminal/linterprete.md)
>
> Attention, le *shebang* est ignoré en faveur de l'interprète choisi.

* En rendant notre script exécutable :

```bash
# A faire une fois
chmod +x world.sh

# Lancer le script
./world.sh
```

> En forme exécutable le *shebang* est très important pour assurer l'exécution de notre script par le bon interprète. 
>
> Dans cette forme, un nouvel interprète est *spawné* comme *child process*.


