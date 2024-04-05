# Lancer des containers

Un avantage de Docker est qu'il existe un énorme bibliothèque d'Images déjà construits pour notre utilisation, qui s'appelle [Docker Hub](https://hub.docker.com).

> Attention : nous allons lancer Docker directement sur votre système hôte, et pas dans VSCode !
>
> D'abord, lancez Docker Desktop si vous êtes sur Windows ou Mac.
>
> * Sur Windows : vous ouvrez PowerShell
> * Sur Linux et Mac : vous ouvrez un Terminal

Nous allons lancer notre premier Container, qui s'appelle [Hello World](https://hub.docker.com/\_/hello-world)

```bash
docker run hello-world
```

Vous allez voir le suivant, par exemple :

```
kevin@Aardvark-II ~ % docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
2db29710123e: Pull complete 
Digest: sha256:94ebc7edf3401f299cd3376a1669bc0a49aef92d6d2669005f9bc5ef028dc333
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

D'abord, l'image n'existe pas en local, donc Docker le télécharge ("pull"). Une fois l'image dans le cache local de notre machine, un nouveau Container est crée sur la base de cet Image. Dans l'image il n'y qu'une seule commande qui émet "Hello from Docker".

On peut tourner n'importe quelle image qui existe sur Docker Hub:

```bash
# le paramètre "-it" veux dire: lancer un séance interactive sur la chaine tty
# Cela veut dire qu'on peut taper des commandes avec le clavier
docker run -it ubuntu:22.04 /bin/bash
```

Essayez de voir la version de Ubuntu en tapant, dans le container :

```bash
lsb_release -a
```

Taper `exit` pour quitter l'interprète. Le processus du Container, `bash` va quitter, et donc le Container est détruit.

Essayez avec une autre image :

```bash
docker run -it node:18 node
```

Ici, on instancie l'image officielle de NodeJS avec la version 18 de node, et on lance l'interprète `node`. Au réplique, on peut taper du javascript !

```bash
kevin@Aardvark-II ~ % docker run -it node:18 node
Welcome to Node.js v18.12.1.
Type ".help" for more information.
> console.log("Hello, this is javascript!")
Hello, this is javascript!
```

Essayez avec Python :

```bash
kevin@Aardvark-II ~ % docker run -it python:3.11 python
Python 3.11.1 (main, Dec 21 2022, 18:32:57) [GCC 10.2.1 20210110] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> print("Hello world!")
Hello world!
>>> 
```

Nous n'avons pas installé python sur notre ordinateur, mais on a pu lancer l'interprète avec Docker.

## Moniteur d'activités docker

Docker nous fourni beaucoup de fonctionnalités via sa commande `docker`.

Par exemple, je peux lister tous les processus gérés par Docker avec :

```bash
docker ps
```

Une liste de processus docker est émis, qui indique :

* Le ID unique de chaque Container
* L'image sur laquelle le Container est crée
* La commande qui tourne
* ...
* Les ports ouverts par le Container
* Le nom du Container (s'il en a un)

## Surveiller les journaux d'un Container

Ayant le ID d'un container qui tourne, je peux consulter les journaux émis :

```bash
docker logs [ID du Container] --follow --tail 5
```

J'ai ajouté 2 paramètres facultatifs mais utiles :

* `--follow` va bloquer le terminal, et afficher en temps réel les nouevaux événements qui arrivent
* `--tail 5` va commencer uniquement à la fin des logs (sinon on va devoir parcourir le tout avant d'arriver à la fin)

## Arrêter un Container

Pour arrête un container :

```bash
docker stop [ID du Container]
```

Vous allez remarquer que le container soit enlevé, si vous faîte `docker ps`. Cette commande arrête le container, mais elle est juste mis en suspense.

## Lister les Containers

On peut voir les containers sur notre machine avec :

```bash
docker ls -a
```

Avec cette commande on voit tous les containers, et leur statuts, y compris ceux qui sont arrêtés.

## Supprimer les Containers

On peut donc supprimer définitivement les Containers qui sont déjà quittés, afin de libérer de la place sur notre ordinateur :

```bash
docker container rm [ID du Container]
```

## Lister / Supprimer les Images

De la même façon on peut lister et supprimer les Images :

```bash
# Lister les images
docker image ls

# Supprimer une image
docker image rm [ID de l'image]
```

Attention, on ne peut supprimer une image seulement s'il n'y a plus de Container (même qui a déjà arrêté) à la base de cette image.

## Nettoyer Docker

Vous avez peut-être constaté que Docker pourrait vite consommer beaucoup de place sur nos disques, entre toutes les Images et tous les containers.

On pourrait faire le menage en faisant :

```bash
docker system prune -a
```

On a pas encore parlé de _Volumes_, mais on peut aussi supprimer les volumes non-utilisés avec :

```bash
docker system prune -a --volumes
```
