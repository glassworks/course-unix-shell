# 🤖 Scripts

Un des grands avantages de notre invite de commandes, et la possibilité de contrôler notre machine UNIX avec des commandes textuelles, et la possibilité de rassembler et répeter nos instructions via des scripts.

* Moins d'erreurs
* Répétition (installations, actions chronologiques, ou autre)
* Gestion de code (git)
* ... etc

Pour vos cours, par exemple, j'ai rédigé un script pour créer vos comptes sur mon serveur :

```bash
#!/bin/bash

GROUP=students
FILE=$1
PUB_KEY_FILE=id_rsa.pub

echo "Reading file $FILE"

if [ -z $FILE ] || [ ! -f $FILE ]; then 
  echo "File $FILE does not exist"
  exit 1
fi


if [ $(getent group $GROUP) ]; then
  echo "group $GROUP exists."
else
  echo "group $GROUP does not exist."
  groupadd students

fi

sed '/^$/d' $FILE

lines=$(cat $FILE)
for line in $lines
do
  email=$(echo $line | xargs | tr [:upper:] [:lower:] | sed -e 's/@/\./g' )
  if [ $(getent passwd $email) ]; then
    echo "User $email exists"
  else
    echo "Creating: $email"
    useradd -m $email
  fi

  if [ ! $(getent group $email) ]; then
    groupadd $email
  fi
  
  usermod -g $email $email
  usermod --shell /bin/bash $email
  mkdir -p /home/$email/.ssh
  if [ ! -f /home/$email/.ssh/authorized_keys ]; then 
    cat $PUB_KEY_FILE > /home/$email/.ssh/authorized_keys
    echo "" >> /home/$email/.ssh/authorized_keys
  fi
  chown -R $email /home/$email/.ssh
  chmod 755 /home/$email/.ssh/authorized_keys

  mkdir -p /var/www/html/$email
  chown -R $email:www-data /var/www/html/$email
  chmod 755 /var/www/html/$email
  # ln -s /var/www/html/$email /home/$email/www
done

```
