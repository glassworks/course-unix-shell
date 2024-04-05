# 📂 Fichiers et répertoires

Une philosophie centrale aux systèmes UNIX est que tout agit comme un fichier, et notamment toute la configuration du système d'exploitation et ses services se trouve en tant qui fichier de type texte.

Par exemple :

* nous récupérons des données certains types périphériques (disques durs, CD ROMS, clé USB, souris...) comme si on lisait un fichier.
* on peut reconfigurer pratiquement tout le système d'exploitation et ses applications via les fichiers text qui se trouvent dans `/etc`
* on peut récupérer des données concernant l'état de notre machine (temperature, mémoire, etc) en lisant des fichiers "spéciaux" dans `/proc`
* etc.

Il est donc essentiel de :

* maîtriser la navigation de l'arborescence de fichiers sur Unix
* pouvoir lister, créer, modifier et supprimer les fichiers et les répertoires
* comprendre comment les permissions fonctionnent sur les fichiers et les répertoires pour une meilleure sécurité
* comprendre comment configurer votre machine via les fichiers text
