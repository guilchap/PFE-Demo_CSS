# Configuration Raspberry

## **Listes des équipements**

- 3 cartes Raspberry
- 3 alimentations
- 1 dongle Wi-Pi
- 2 cartes Micro SD
- 1 carte SD

*Suppléments lors de l'installation :*
- *3 câbles ethernet*
- *3 câbles HDMI*
- *3 claviers*


## **Informations sur le système final**

1 carte Raspberry sert de router Wi-Fi

2 cartes Raspberry servent de datacenter fonctionnant en cluster stockant des sites web.


## **Installation**

Par la suite les cartes Raspberry seront appelés par leur utilité. Pour les cartes simulant les datacenter, l'une est située à Angers l'autre à Dijon.

1. Router Wi-Fi (câble HDMI + câble ethernet requis)

   - Brancher la carte en alimentation, HDMI, ethernet et au clavier
   - Se connecter avec l'utilisateur instancié lors de l'installation de l'OS sur la carte de stockage
   - Entrer dans l'interface de configuration pour modifier le "WLAN Region"
        ```
        sudo raspi-config
        ```
   - Installer git et le configurer
        ```
        sudo apt-get install -y git
        ```
   - Cloner le repository dans le dossier souhaité
        ```
        cd /
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
   - Entrer dans l'interface de configuration pour modifier le "WLAN Region"
        ```
        sudo raspi-config
        ```
   - Installer git et le configurer
        ```
        sudo apt-get install -y git
        ```
   - Cloner le repository dans le dossier souhaité
        ```
        cd /
        sudo git clone --branch datacenter-wifi https://github.com/guilchap/PFE-Demo_CSS.git
        ```
   - Installer tous les packages requis
        ```
        # Datacenter Dijon
        sh /PFE-Demo_CSS/raspberry/dijon/install.sh

        # Datacenter Angers
        sh /PFE-Demo_CSS/raspberry/angers/install.sh
        ```
   - Rédemarrer la machine et débrancher les câbles HDMI et ethernet
        ```
        sudo reboot
        ```


3. Datacenter Dijon (connexion ethernet avec le Datacenter Angers requise)

   - Lancer le script de configuration Wi-Fi
        ```
        # Configuration Wi-Fi
        sh /PFE-Demo_CSS/raspberry/dijon/conf_wifi.sh
        ```
    - Entrer dans l'interface de configuration pour se connecter au Wi-Fi
        ```
        sudo raspi-config
        ```
    - Lancer les scripts de configuration
        ```
        # Configuration cluster
        sh /PFE-Demo_CSS/raspberry/dijon/conf_cluster.sh 

        # Configuration cluster
        sh /PFE-Demo_CSS/raspberry/dijon/conf_prometheus.sh 

        # Configuration cluster
        sh /PFE-Demo_CSS/raspberry/dijon/conf_apache.sh 
        ```
   - Rédemarrer la machine
        ```
        sudo reboot
        ```

4. Datacenter Angers (connexion ethernet avec le Datacenter Dijon requise)

   - Lancer le script de configuration Wi-Fi
        ```
        # Configuration Wi-Fi
        sh /PFE-Demo_CSS/raspberry/dijon/conf_wifi.sh
        ```
    - Entrer dans l'interface de configuration pour se connecter au Wi-Fi
        ```
        sudo raspi-config
        ```
    - Lancer les scripts de configuration
        ```
        # Configuration cluster
        sh /PFE-Demo_CSS/raspberry/angers/conf_cluster.sh 

        # Configuration cluster
        sh /PFE-Demo_CSS/raspberry/angers/conf_prometheus.sh 

        # Configuration cluster
        sh /PFE-Demo_CSS/raspberry/angers/conf_apache.sh 
        ```
   - Rédemarrer la machine
        ```
        sudo reboot
        ```