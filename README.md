# Analyse des logs : Mise en place d'une pile "ELKG" 
# Environnement de test Docker avec Docker-compose 
#
#
## Arborescence valide
```
$ tree 
.
├── configurations.env
├── docker-compose.yml
├── elasticsearch
│   ├── conf.sh
│   ├── Dockerfile
├── graylog
│   ├── conf.sh
│   ├── Dockerfile
└── README
```

## Lancement et utilisation 

### Prérequis 
Assurez-vous d'avoir installé [Docker](https://docs.docker.com/linux/started/) et [Docker-compose](https://docs.docker.com/compose/install/)

### Lancement des trois containers (kibana, elasticsearch & graylog)
```
$ cd <repertoire_docker_compose_yml> 
$ docker-compose up 
 ```
Note : Utiliser `docker-compose stop` pour stopper les trois containers et `docker-compose start` pour les relancer 

### Utilisation des services 
* Elasticsearch : http://<ip_docker_host>:9200/_plugin/head
* Graylog : http://<ip_docker_host>
* Kibana : http://<ip_docker_host>:5601


## Modification du fichier `docker-compose.yml` 
* Changement de redirection de ports : ne changer que la partie gauche des paramètres "ports:" 
  `"<port_hote_pouvant_etre_changé>:9300"` par exemple
* Changement de dossier de persistance : ne changer que la partie gauche des paramètres "volumes:" 
  `"<chemin_volume_hote_pouvant_etre_changé>:/var/graylog"` par exemple
* Changement du mode réseau, à choisir entre : 
```
net: "bridge"
net: "none"
net: "container:[name or id]"
net: "host"
```

## Modification du fichier `configurations.env` 
Modifier les variables de configurations de Graylog, Elasticsearch et Kibana en changeant les valeurs adéquates dans `configurations.env` 





