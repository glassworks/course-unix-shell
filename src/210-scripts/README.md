# 🤖 Scripts

Un des grands avantages de notre invite de commandes, et la possibilité de contrôler notre machine UNIX avec des commandes textuelles, et la possibilité de rassembler et répeter nos instructions via des scripts.

* Moins d'erreurs
* Répétition (installations, actions chronologiques, ou autre)
* Gestion de code (git)
* ... etc

Pour vos cours, par exemple, j'ai rédigé un script pour créer vos comptes sur mon serveur :

```bash
#!/bin/bash

# Déclarer des variables
GROUP=students
FILE=students.txt
PUB_KEY_FILE=id_rsa.pub

# Créer le groupe "studens" s'il n'existe pas
if [ $(getent group $GROUP) ]; then
  echo "group $GROUP exists."
else
  echo "group $GROUP does not exist."
  groupadd students

fi

# Enlever les lignes blancs du fichier des étudiants
sed '/^$/d' $FILE

# Itérer sur les lignes du fichier
lines=$(cat $FILE)
for line in $lines
do
  # Nettoyer l'adresse e-mail
  email=$(echo $line | xargs | tr [:upper:] [:lower:] | sed -e 's/@/\./g' )
  if [ $(getent passwd $email) ]; then
    echo "User $email exists"
  else
    # Créer un nouveau utilisateur
    echo "Creating: $email"
    useradd -m -g students $email
  fi
  
  usermod --shell /bin/bash $email
  mkdir -p /home/$email/.ssh
  cat $PUB_KEY_FILE > /home/$email/.ssh/authorized_keys

  mkdir -p /var/www/html/$email
  chown -R $email:students /var/www/html/$email
  chmod 755 /var/www/html/$email
done

```
