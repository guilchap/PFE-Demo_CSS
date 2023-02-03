# PFE CSS 2022/2023

Est stocké dans cette branche git la page produit

## Démonstrateur d'option CSS

### Machine virtuelle Controleur

Technologie de virtualisation: Vagrant<br/><br/>

Arbre des fichiers:

    ├── controller
    |   ├── data
    |   ├── logs
    |   ├── scripts
    |   ├── .gitignore
    |   ├── README.md
    |   └── Vagrantfile
    └── README.md

Les instructions pour construire et utiliser la machine virtuelle se trouve sur le README.md du dossier controller.<br/><br/>

Informations sur le système finale :

La VM controleur possède de nombreux service comme apache, tomcat pour le site web, grafana pour la supervision des Raspberry PI et 
docker pour la conteneurisation d'un serveur linux.
