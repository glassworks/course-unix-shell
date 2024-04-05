# Volumes

Avec docker, on peut _monter_ un répertoire de notre machine hôte dans le système de fichiers d'un Container.

En fait, par défaut, quand on Container est crée par Docker à partir d'une image, une volume, qui existe dans `/var/lib/docker/volumes/` dans laquelle se trouve des fichiers provenant de l'Image de source.

Imaginons le cas suivant :

* Sur mon ordinateur, j'ai développé une mini application en javascript :

```js
const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

rl.on('line', (line) => {
  
  if ((line || '').trim().toLowerCase() === 'non') {
    process.exit();
  } else {

    console.log(`Vous avez dit: "${line}".`);
    console.log("Est-ce que vous avez autre chose à dire ?");
  }

  
});

rl.once('close', () => {
  process.exit();
});

console.log("Est-ce que vous avez quelque chose à dire ?");
```

Je peux _monter_ l'emplacement de ce fichier en tant que volume dans le container, avec un paramètre `-v`:

```bash
# -v [emplacement sur la machine hôte]:[emplacement dans le Container]
docker run -it -v /Users/kevin/Desktop/test:/app  node:18 node /app/app.js
```

Ici on monte le dossier `/Users/kevin/Desktop/test` sur la machine hôte à l'emplacement `/app` dans le Container. Ensuite, on peut préciser que node se lance en lisant mon fichier javascript, qui explique la fin de la ligne : `node /app/app.js`.

On peut également rentrer dans notre Container pour le voir :

```bash
docker run -it -v /Users/kevin/Desktop/test:/app node:18 bash 
```

Ensuite, effectuez un `ls /`... vous verrez le dossier `/app`.
