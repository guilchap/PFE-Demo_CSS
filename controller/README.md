# Configuration de la machine virtuelle controleur
## Liste du matériel

Machine virtuelle: <br/>
OS: Debian bullseye64 <br/>
CPU: 2 <br/>
Memoire: 1024 <br/>
network: ethernet, wifi (ip fixe) <br/>
Outil de virtualisation: virtualBox <br/>

## Informations sur le système finale

La VM controleur possède de nombreux service comme apache, 
tomcat pour le site web, grafana pour la supervision des Raspberry PI et 
docker pour la conteneurisation d'un serveur linux.

## Démarrage de la VM

### Pré-requis
Avoir installé sur l'ordinateur Vagrant, virtualbox.

### Démarrage
Dans un terminal de commande, dans le dossier contenant le Vagrantfile, lancer la commande:<br/><br/> `vagrant up`<br/><br/>
Laisser le temps à la VM de démarrer. <br/>
Lors des demandes d'interface, choisir l'interface ethernet pour eth1 (1ere fois) et l'interface wifi pour eth2 (2eme fois).<br/>
Brancher la carte Raspberry faisant office de wifi, se connecter au wifi avec le mot de passe. <br/><br/>

Se connecter au site Etudiant de la VM controleur à l'adresse: <br/>
`http://192.168.25.5`<br/>
ou dans le cas où le fichier hosts de la machine client a été modifié: <br/>
`http://demo.css.eseo/`<br/><br/>

Se connecter au site Admin de la VM controleur à l'adresse: <br/>
`http://192.168.25.5/admin/`<br/>
ou dans le cas où le fichier hosts de la machine client a été modifié: <br/>
`http://demo.css.eseo/admin/`<br/>
