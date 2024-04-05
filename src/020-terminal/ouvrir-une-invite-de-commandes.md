# Ouvrir une invite de commandes

Pratiquement tous les systèmes d'exploitation possède leur propre invite de commandes :

1. Windows : **PowerShell**
2. Linux : **sh / bash / zsh / ...**
3. MacOS : **sh / bash / zsh / ...**

Dans ce cours, nous allons se concentrer sur l'invite de commandes basé sur Unix, dont Linux (sh, bash, etc).

> Je vous ai passé un Container Docker qui simule un environnement Ubuntu dans VSCode, quoi que ce soit votre système d'exploitation. Vous pouvez suivre tous les cours avec cet environnement.

## Windows

Windows ne possède pas une invite de commandes UNIX par défaut. Si vous tapez "Invite de commandes" dans la barre de recherche, vous aurez plutôt une instance de **PowerShell** qui **n'utilise pas le même syntax que dans ce cours**.

Vous avez d'autres options pour ouvrir un invite de commandes Ubuntu.

Avec le projet VSCode [configuré ici](../010-introduction/installation-party.md), vous aurez une invite de commandes configurée parfaitement pour ce cours.

D'autres options :

* Vous pouvez lancer directement une invite de commandes Ubuntu avec WSL
* Pouvez installer et utiliser [mingw](https://www.mingw-w64.org)

## **MacOS**

MacOS est une système initialement basé sur UNIX, et donc inclut par défaut une invite de commandes. Il suffit de chercher l'application "Terminal" et la lancer.

## **Linux**

Linux est intièrement basé sur UNIX. Dans les interfaces graphiques de Linux, on a souvent une application qui s'appelle "Terminal". Sinon, à tout moment on peu appuyer sur `Ctrl+Alt+F(1 à 6)` afin d'ouvir une nouvelle invite de commandes.
