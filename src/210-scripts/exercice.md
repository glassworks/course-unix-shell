# Exercice : un script CGI pour Apache

Vous avez déployé du contenu .html sur mon serveur `unixshell.hetic.glassworks.tech` dans [un exercice précédent](../080-apache/exercice1.md).

On peut aussi demander à Apache, au lieu juste de servir un fichier static, d'exécuter un script et renvoyer le résultat de ce script.

En pratique, Apache va récupérer le résultat du `stdout` de notre script, et le renvoyer au client.

Pour ce faire, il y aura quelques modifications à apporter :

1. Dans votre fichier `.htaccess` il faut activer l'exécution des scripts via le module `cgi` :

```bash
Options +ExecCGI
AddHandler cgi-script .cgi
```

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

1. Ensuite on crée un script avec extension `.cgi`. Par exemple, `index.cgi` :

```bash
#!/bin/bash

# EN-TÊTE
# Dans le standard HTTP, on est obligé de retourner une ligne avec le type de contenu
echo "Content-Type: text/plain"
# Suivi par une ligne vide
echo ""

# CORPS
# Ensuite, on peut faire notre logique et envoyer notre contenu.
# Ici, on va juste retourner un peu de text

echo "This is the result of a script!"
```

1. Modifiez les droits de ce fichier pour le rendre exécutable :

```bash
chmod 755 index.cgi
```

> A noter, si vous êtes administrateur de ce serveur, il faut d'abord activer le module CGI avec :
>
> ```bash
> a2enmod cgi
> ```

Vous pouvez ensuite consulter ce fichier à :

```
https://unixshell.hetic.glassworks.tech/[IDENTIFIANT]/index.cgi

# A noter [IDENTIFIANT] est votre adresse e-mail avec le @ remplacé par un .
```

Rédigez un fichier text qui s'appelle "greeting.txt" et qui contient un message de bienvenue pour votre visiteur, par exemple:

```bash
Bonjour, vous êtes bienvenue !
```

Adaptez le script `index.cgi` pour lire ce fichier (avec `cat` par exemple), et renvoyer le résultat à l'utilisateur. L'idée est qu'on puisse modifier les contenus du fichier `greeting.txt` sans devoir modifier notre script.

Malgré le contenus de notre fichier `greeting.txt`, il faut toujours terminer la page avec le texte : `Fin de page!`.

Est-ce que les caractères spéciaux s'afficher correctement ? Comment résoudre ce problème ?

<details>

<summary>Solution</summary>

```bash
#!/bin/bash

echo "Content-Type: text/plain; charset=utf-8"
echo ""

cat greeting.txt

echo "Fin de page!"
```

</details>
