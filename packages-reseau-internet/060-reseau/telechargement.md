# Télécharger des fichiers

Quand on veut installer une machine à distance, il n'est pas très facile à envoyer des fichiers sur le serveur. On pourrait envoyer les fichiers par le protocole `ftp` par exemple, mais parfois il est plus simple de récupérer le fichier du web. Surtout si on a déjà une invite de commandes déjà ouverte sur ce serveur.

La commande `wget` est donc très utile. C'est un outil qui permet de chercher et télécharger un fichier de son `URL`.

Par exemple, nous avons une invite de commandes ouvert sur un serveur sur lequel on veux installer WordPress.

On peut télécharger WordPress ici :

```bash
wget https://wordpress.org/latest.zip
```

Le fichier est téléchargé à l'emplacement actuel de l'invite de commandes.

```bash
kevin%nguni.fr@unix-shell-students:~$ ls -l
total 23876
-rw-r--r-- 1 kevin%nguni.fr students 24369959 nov.  15 20:04 latest.zip
-rw-r--r-- 1 kevin%nguni.fr students    76030 janv.  2 10:04 README.md
```

Ensuite on pourrait décompresser le fichier avec `unzip` :

```bash
unzip latest.zip
```

Vérifiez le nouveau répertoire :

```bash
kevin%nguni.fr@unix-shell-students:~$ ls -l
total 23880
-rw-r--r-- 1 kevin%nguni.fr students 24369959 nov.  15 20:04 latest.zip
-rw-r--r-- 1 kevin%nguni.fr students    76030 janv.  2 10:04 README.md
drwxr-xr-x 5 kevin%nguni.fr students     4096 nov.  15 20:03 wordpress
```
