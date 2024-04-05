#!/bin/bash

SECRET_KEY=

docker build . --tag unix-shell-vscode:latest

docker tag unix-shell-vscode:latest  rg.fr-par.scw.cloud/unix-shell-vscode/unix-shell-vscode:latest

docker login rg.fr-par.scw.cloud/unix-shell-vscode -u nologin --password-stdin <<< "${SECRET_KEY}"

docker push rg.fr-par.scw.cloud/unix-shell-vscode/unix-shell-vscode:latest 