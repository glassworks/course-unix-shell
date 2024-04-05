# Docker Compose

Même si la commande `docker` est très puissant, il y a beaucoup de commandes à retenir.

Autant créer un fichier de configuration, qui précise l'image à utiliser, le volumes à monter etc. 

Ce fichier s'appelle `docker-compose.yml` et il est en format `yaml`:

Créez, dans le même répertoire que votre fichier `app.js`, un fichier qui s'appelle `docker-compose.yml` :

```yaml
version: '3.9'

services:
  my-node-app:
    image: node:18
    working_dir: /app
    volumes:
      - ./:/app
    command: node app.js
```

Ensuite on peut lancer notre *service* avec :

```bash
docker compose run my-node-app
```

Cette fois si, la configuration du Container y compris l'image à utiliser, les volumes à monter et la commande à exécuter, est lu du fichier.

Il est possible de préciser plusieurs services dans le même fichier `docker-compose.yml` et les lancer indépendamment. Docker créera un Container pour chaque service. 

La plupart du temps, on aimerait lancer un service qui agit comme *serveur*, c'est à dire, il attend des messages réseau (et non pas des éntrées claviers). Par exemple :
* Un serveur SQL (base de données)
* Un API
* Un site en PHP qui est servi par Apache
* ...

On peut préciser l'ensemble dans un `docker-compose.yml`, puis contrôler le tout avec :

```bash
# Lancer tous les services en tâche de fond
docker compose up -d

# Arr^ter tous les services
docker compose down
```

## Notre projet VSCode

Regardez dans le fichier `.devcontainer/docker-compose.yml` du projet du cours :

```yml
version: '3.9'

services:
  vscode_unix_shell:
    # build: 
    #  context: ./
    #  dockerfile: ./Dockerfile
    image: rg.fr-par.scw.cloud/unix-shell-vscode/unix-shell-vscode:latest
    command: /bin/bash -c "while sleep 1000; do :; done"
    working_dir: /home/hetic
    networks:
      - app-network
    volumes:
      - ../:/home/hetic:cached

networks:
  app-network:
    driver: bridge
```

Dans la première version de ce fichier, j'avais construit mon Container en local, c'est à dire, j'ai précisé un Dockerfile (qui existe dans le même dossier), qui contient toutes les instructions pour construire mon Container. Les lignes commentées (`build`), permet de construire automatiquement l'image à partir du Dockerfile au lancement de `docker compose`.

Un fois stable, j'ai plutôt déployé mon image dans un dépôt docker privée (*Container Registry*). Ceci peut être sur Docker Hub (on peut avoir un compte gratuit, mais il est limité en nombre d'utilisateurs). Mon fournisseur Cloud, Scaleway, propose aussi l'option de Container Registry. J'ai donc construit et déploy mon Image avec les instructions suivantes :

```bash
# Construire l'image
docker build . --tag unix-shell-vscode:latest

# Changer le tag de l'image, pour préciser qu'elle doit exister dans un autre dépôt
docker tag unix-shell-vscode:latest  rg.fr-par.scw.cloud/unix-shell-vscode/unix-shell-vscode:latest

# Se connecter au dépôt
docker login rg.fr-par.scw.cloud/unix-shell-vscode -u nologin --password-stdin <<< "${SECRET_KEY}"

# Envoyer l'image vers le dépôt
docker push rg.fr-par.scw.cloud/unix-shell-vscode/unix-shell-vscode:latest 
```

J'ai ensuite remplacé les lignes `build` par `image`, en précisant l'identifiant de l'image.

En fait, quand on utilise `Reopen in Container`, Docker fait le suivant :
* L'image est récupérée du Container Registry
* Un Container est lancé, avec la command `bash` qui reste continuellement ouvert grâce à une boucle infinie
* On monte le dossier parent de `.devcontainer` à l'emplacement `/home/hetic` dans le Container
* Après VSCode établit une connexion avec ce Container, qui nous permet d'ouvrir un Terminal comme si on était dans Ubuntu.

Regardez le fichier `Dockerfile`. Il s'agit d'une liste d'instructions qui explique comment créer une image personnalisée. 

En ce concerne le Dockerfile, on n'est pas sensé tout comprendre pour le moment, mais on peut déjà dire que notre base de départ est l'image `ubuntu:22.04` :

```bash
FROM ubuntu:22.04
# Forcer le faite d'utiliser les miroirs français quand on utilise apt ...
COPY ./sources.list /etc/apt/sources.list

ARG USERNAME=hetic
ARG USER_UID=1000
ARG USER_GID=$USER_UID
...
```

## Mises à jour des images

Si jamais une Image se met à jour dans le dépôt on peut facilement la récupérer :

```bash
# Directement avec Docker
docker pull rg.fr-par.scw.cloud/unix-shell-vscode/unix-shell-vscode:latest 

# Ou avec docker compose
docker compose pull vscode_unix_shell
docker compose up vscode_unix_shell
```




