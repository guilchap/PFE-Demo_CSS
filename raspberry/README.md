# Configuration Raspberry

## **Listes des équipements**

- 3 cartes Raspberry
- 3 alimentations
- 1 dongle Wi-Pi
- 2 cartes Micro SD
- 1 carte SD

*Suppléments lors de l'installation :*
- *câble ethernet, câble HDMI, clavier*

## **Informations sur le système final**

1 carte Raspberry PI sert de router Wi-Fi.

2 cartes Raspberry PI servent de datacenter fonctionnant en cluster hébergeant des sites web.


## **Installation**

Par la suite, les cartes Raspberry PI seront appelées par leur utilité.<br/>
Pour les cartes simulant les datacenter, leur nom est déterminé par leur localisation : l'une à Angers et l'autre à Dijon.

1. Router Wi-Fi (câble HDMI + câble ethernet requis)

   - Brancher la carte en alimentation, HDMI, ethernet et au clavier
   - Se connecter avec l'utilisateur instancié lors de l'installation de l'OS sur la carte de stockage
   - Entrer dans l'interface de configuration pour modifier le "WLAN Region"
        ```
        sudo raspi-config
        Rédemmarage protentiellement recommandé
        ```
   - Installer git et le configurer
        ```
        sudo apt-get install -y git
        ```
   - Cloner le repository dans le dossier racine de l'utilisateur
        ```
        cd /home/piWifi/
        sudo git clone --branch datacenter-wifi https://github.com/guilchap/PFE-Demo_CSS.git
        ```
   - Lancer le script de configuration du Wi-Fi
        ```
        sh /PFE-Demo_CSS/raspberry/wifi-hotspot/conf_wifi.sh
        ```
   - Rédemarrer la machine et débrancher les câbles HDMI et ethernet
        ```
        sudo reboot
        ```


2. Datacenter Dijon et Angers (câble HDMI + câble ethernet requis)

   - Brancher la carte en alimentation, HDMI, ethernet et au clavier
   - Se connecter avec l'utilisateur instancié lors de l'installation de l'OS sur la carte de stockage
   - Entrer dans l'interface de configuration pour modifier le "WLAN Region" et "l'auto-login"
        ```
        sudo raspi-config
        Rédemmarage protentiellement recommandé
        ```
   - Installer git et le configurer
        ```
        sudo apt-get install -y git
        ```
   - Cloner le repository dans le dossier souhaité
        ```
        # Datacenter Dijon
        cd /home/piDijon/
        sudo git clone --branch datacenter-wifi https://github.com/guilchap/PFE-Demo_CSS.git
        
        # Datacenter Angers
        cd /home/piAngers/
        sudo git clone --branch datacenter-wifi https://github.com/guilchap/PFE-Demo_CSS.git
        ```
   - Installer tous les packages requis
        ```
        # Datacenter Dijon
        sh /home/piDijon/PFE-Demo_CSS/raspberry/dijon/install.sh

        # Datacenter Angers
        sh /home/piAngers/PFE-Demo_CSS/raspberry/angers/install.sh
        ```
   - Rédemarrer la machine et débrancher les câbles HDMI et ethernet
        ```
        sudo reboot
        ```


3. Datacenter Dijon (connexion ethernet avec le Datacenter Angers requise)

   - Lancer le script de configuration Wi-Fi
        ```
        # Configuration Wi-Fi
        sh /home/piDijon/PFE-Demo_CSS/raspberry/dijon/conf_wifi.sh
        ```
    - Entrer dans l'interface de configuration pour se connecter au Wi-Fi
        ```
        sudo raspi-config
        ```
    - Lancer les scripts de configuration
        ```
        # Configuration cluster
        sh /home/piDijon/PFE-Demo_CSS/raspberry/dijon/conf_cluster.sh 

        # Configuration Apache
        sh /home/piDijon/PFE-Demo_CSS/raspberry/dijon/conf_apache.sh 

        # NON RECOMMANDE
        # Configuration Prometheus
        sh /home/piDijon/PFE-Demo_CSS/raspberry/dijon/conf_prometheus.sh 

        # NON RECOMMANDE
        # Configuration NetData
        sh /home/piDijon/PFE-Demo_CSS/raspberry/dijon/conf_apache.sh
        ```
   - Rédemarrer la machine
        ```
        sudo reboot
        ```

4. Datacenter Angers (connexion ethernet avec le Datacenter Dijon requise)

   - Lancer le script de configuration Wi-Fi
        ```
        # Configuration Wi-Fi
        sh /home/piAngers/PFE-Demo_CSS/raspberry/angers/conf_wifi.sh
        ```
    - Entrer dans l'interface de configuration pour se connecter au Wi-Fi
        ```
        sudo raspi-config
        ```
    - Lancer les scripts de configuration
        ```
        # Configuration cluster
        sh /home/piAngers/PFE-Demo_CSS/raspberry/angers/conf_cluster.sh 

        # Configuration Apache
        sh /home/piAngers/PFE-Demo_CSS/raspberry/angers/conf_apache.sh
        
        # NON RECOMMANDE
        # Configuration Prometheus
        sh /home/piAngers/PFE-Demo_CSS/raspberry/angers/conf_prometheus.sh 

        # NON RECOMMANDE
        # Configuration NetData
        sh /home/piAngers/PFE-Demo_CSS/raspberry/angers/conf_apache.sh
        ```
   - Rédemarrer la machine
        ```
        sudo reboot
        ```

Variables utilisées dans le projet:
   1. Identifiants des cartes Raspberry PI:
      - Router Wifi : 
         - username: piWifi
         - password: raspwifi
      - Datacenter Dijon : 
         - username: piDijon
         - password: raspdijon
      - Datacenter Angers : 
         - username: piAngers
         - password: raspangers
   2. Identifiants du Wifi:
      - username: CSS-HOTSPOT
      - password: Cl0udC0mputin9PF3
