# Unix Package Manager

La plupart des distributions Linux viennent avec un *package manager*, c'est à dire un système pour la gestion des extensions et logiciels.

Le *package manager* s'agit d'une commande pour installer, désinstaller, et mettre à jour les logiciels, les commandes, et le *kernel* de notre système d'exploitation.

Selon la distribution, la commande change :
* Sur Debian / Ubuntu : `apt`
* Sur Suse : `yum`
* Sur d’autres ... ? 

Par exemple, sur les distributions basé sur Debian et/ou Ubuntu :

```bash
# Mettre à jour l’indexe de logiciels disponibles avec leur dernières versions
apt update 

# Installer un logiciel
apt install [nom du logiciel]

# Désinstaller un logiciel
apt remove [nom du logiciel]

# Mettre à jour le logiciels déjà installés
apt upgrade
```

## Exercice

Testez si vous avez les commandes suivantes dans vos invites de commandes, en tapant la commande. Si vous rencontrez une erreur, c'est que la commande n'est pas installée. Utilisez `apt` pour les installer :

```bash
# Un logiciel pour télécharger un fichier du web
wget

# Compresser des fichiers et dossiers
zip

# Décompresser des fichiers et dossiers
unzip
```





