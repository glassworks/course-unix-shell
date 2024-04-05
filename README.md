---
cover: .gitbook/assets/banner.svg
coverY: 0
---

# Unix Shell

Bienvenue au cours Unix Shell, conçu par Kevin Glass, Ph.D.

Ce document : [https://docs.glassworks.tech/unix-shell/](https://docs.glassworks.tech/unix-shell/)

[Récupérez les sources ainsi que les ressources de ce programme ici.](https://github.com/glassworks/course-unix-shell)

## Copyright

Copyright © Kevin Glass 2024.

La rédaction de ce programme a été faite par Kevin Glass, y compris la création des exemples, exercices, et données de test.

Toute ré-utilisation du contenu de ce cours est sujet à l'accord exprès et à l'écrit de Kevin GLASS.


## Docker Registry

Le container `vscode_unix_shell` utilise une image Docker personnalisé. Les instructions pour sa création et déploiement sont :

```bash
# Terminal ouvert à la racine de ce projet

# D'abord : ouvrez Docker Desktop, allez dans "Reglages", et activer "Use ContainerD for pulling and storing images"

# Build l'image en local
#docker build  -t unixshell_dev_vscode -f ./docker/Dockerfile.dev .
docker buildx build --platform linux/amd64,linux/arm64  -t unixshell_dev_vscode -f ./.devcontainer/Dockerfile .

# Trouver l'image
docker image ls | grep "unixshell_dev_vscode"  

# Retagger l'image avec l'adresse du repo at le numéro de version
docker tag unixshell_dev_vscode rg.fr-par.scw.cloud/unix-shell-vscode/unix-shell-vscode:latest

# Créer une clé de connexion chez scaleway
SCW_SECRET_KEY=
docker login rg.fr-par.scw.cloud/unix-shell-vscode -u nologin --password-stdin <<< "$SCW_SECRET_KEY"

# Envoyer l'image dans le dépôt docker sur Scaleway
docker push rg.fr-par.scw.cloud/unix-shell-vscode/unix-shell-vscode:latest
```