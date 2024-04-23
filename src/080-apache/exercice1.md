# 🏅 Exercice : configurer votre espace web

_Apache_ est un serveur web très puissant qui existe depuis longtemps, et il est utilisé par un tier des serveurs du monde.

Par défaut, Apache sert des fichiers statiques du répertoire `/var/www/html`. En créant votre compte, je vous ai déjà crée un dossier dans lequel vous pouvez servir vos fichiers sous `/var/www/html/[UTILISATEUR]`.

Par exemple, mon espace web (avec mon identifiant `kevin.nguni.fr`) est à :

```bash
/var/www/html/kevin.nguni.fr
```

Utilisez votre accès à mon serveur à `unixshell.hetic.glassworks.tech` afin de réaliser les tâches suivantes :

1. J'aimerais plus facilement accéder à mon espace web à partir de mon répertoire maison, notamment `~/www`. Créez un lien symbolique qui me permet d'ajouter ou modifier mon espace web plus facilement.
2. Créez une page HTML avec le texte "Hello world" dans le dossier `~/www`. Vous devriez pouvoir naviguer à cette page dans un navigateur web au lien suivant :

[https://unixshell.hetic.glassworks.tech/\[UTILISATEUR\]/index.html](https://unixshell.hetic.glassworks.tech/\[UTILISATEUR]/index.html)

Par exemple, pour mon compte :

[https://unixshell.hetic.glassworks.tech/kevin.nguni.fr/index.html](https://unixshell.hetic.glassworks.tech/kevin.nguni.fr/index.html)

1. Si on navigue simplement au dossier parent de l'espace web, par exemple, à `https://unixshell.hetic.glassworks.tech/kevin.nguni.fr/`, j'aimerais voir une liste des fichiers du dossier `www`. Ceci se fait par le fichier de configuration `~/www/.htaccess`. Ajoutez la ligne suivante à ce fichier, et réessayer :

```
Options +Indexes
```

1. Regardez la documentation pour la directive `Options` de fichier `.htaccess` [ici](https://httpd.apache.org/docs/2.4/mod/core.html#options). Voyez-vous d'autres options utiles ?
2. J'aimerais automatiquement sélectionner le fichier `index.html` quand je navigue vers ma page web. Par exemple, [https://unixshell.hetic.glassworks.tech/kevin.nguni.fr](https://unixshell.hetic.glassworks.tech/kevin.nguni.fr) devrait afficher par défaut la page `index.html` au lieu d'afficher un listing des fichiers. Consultez [la documentation pour `DirectoryIndex`](https://httpd.apache.org/docs/2.4/mod/mod\_dir.html#directoryindex) pour savoir comment modifier votre `.htaccess`.

> Si vous avez configuré vous même votre serveur Apache, il faut être sur d'avoir activé la lecture de `.htaccess`. Vous l'activez, site par site, dans `/etc/apache2/sites-enabled/000-default.conf` :
>
> ```bash
> <VirtualHost *>
>   ...
>   <Directory /var/www/html/>
>     # Cette ligne autorise que .htaccess soit lu 
>     AllowOverride All
>     Options -Indexes
>     DirectoryIndex disabled
>   </Directory>
>   ...
> </VirtualHost>
> ```
>
> Ensuite, vous redémarrez Apache avec : `systemctl restart apache2`

## Solutions

<details>

<summary>Créer le lien symbolique</summary>

```bash
ln -s /var/www/html/[UTILISATEUR] www
```

</details>

<details>

<summary>Le fichier `~/www/.htaccess`</summary>

```bash
vi ~/www/.htaccess
```

Avec les contenus :

```bash
Options +Indexes
DirectoryIndex index.html
```

</details>

