# Analyse des logs : Mise en place d'une pile "ELKG" 
Environnement de test Docker avec Docker-compose 

#
## Arborescence valide
```bash
$ tree 
.
├── configurations.env
├── docker-compose.yml
├── elasticsearch
│   ├── conf.sh
│   └── Dockerfile
├── graylog
│   ├── conf.sh
│   └── Dockerfile
├── LICENSE
├── logstash
│   └── logstash.conf
└── README.md
```

## Lancement et utilisation 

### Prérequis 
Assurez-vous d'avoir installé [Docker](https://docs.docker.com/linux/started/) et [Docker-compose](https://docs.docker.com/compose/install/)

### Initialisation 
```bash
$ cd <repertoire_docker_compose_yml> 
$ docker-compose up 
 ```

### Arrêt/Lancement des containers Elasticsearch, Logstash, Kibana & Graylog
* Il est possible (après avoir exécuté une fois `docker-compose up`) d'arrêter les containers :  
```bash
$ cd <repertoire_docker_compose_yml> 
$ docker-compose stop 
```
* Pour les relancer, il suffit de faire : 
```bash
$ cd <repertoire_docker_compose_yml> 
$ docker-compose start 
```
* Pour stopper puis relancer, il suffit de faire : 
```bash
$ cd <repertoire_docker_compose_yml> 
$ docker-compose restart 
```

### Utilisation des services 
* Elasticsearch : http://<ip_docker_host>:9200/_plugin/head
* Graylog : http://<ip_docker_host>
* Kibana : http://<ip_docker_host>:5601

## Configurations 

### Modification du fichier `docker-compose.yml` 
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

### Modification du fichier `configurations.env` 
Modifier les variables de configurations de Graylog, Elasticsearch et Kibana en changeant les valeurs adéquates dans `configurations.env` 

### Quid de Logstash 

#### Modification du fichier `logstash.conf` 
Le dossier `logstash` est lié à un volume persistant du container Logstash. Le fichier de configuration `logstash.conf` peut être modifié à souhait.  
Assurez-vous que le fichier est bien de la forme : 
```
input { 
 ## inputs désirés   
}
filter {
 ## filtres quelconques 
}
output {  
 gelf { host => "adr.ip.graylog.accessible" }
 stdout { codec => rubydebug }
 ## autres sorties 
}
```

Pour avoir un meilleur contrôle du processus Logstash, accédez au bash du container Logstash avec `docker exec <cont_id> bash` (`<cont_id>` est l'id du container, vous pouvez l'obtenir avec la commande `docker ps`). Modifiez le fichier de configuration de Logstash `logstash/logstash.conf` sur la machine hôte comme bon vous semble et relancez à distance le processus de parsing avec la commande `logstash -f /config-dir/logstash.conf`. 

Exemple : 
```bash 
dev29-user@dev29-machine:~$ nano logstash/logstash.conf          #### Modifications du fichier 
dev29-user@dev29-machine:~$ docker exec -it 3203ed92914d  bash   #### Execution d'un bash sur le container 
      ### On est sur le container et on prend la main sur le processus Logstash
root@dev29-machine:/$ logstash -f /config-dir/logstash.conf      
```

#### Cas avec des processus Logstash externes 

Le fichier de configuration de Logstash est amené à être souvent modifié. De plus, il est possible que Logstash soit installé sur plusieurs machines. Il est donc intéressant d'avoir Logstash sur d'autres machines. 

##### Installations avec Docker ([plus d'informations ici](https://hub.docker.com/_/logstash/))

```bash 
docker run -it --rm logstash logstash -e 'input { stdin { } } output { gelf { host => "adr.ip.graylog.accessible" } } 
```
ou 
```bash 
docker run -it --rm -v "$PWD":/config-dir logstash logstash -f /config-dir/logstash.conf 
# (`logstash.conf` dans le dossier courant)
```  

##### Installation classique 
Plus d'informations [ici](https://www.elastic.co/downloads/logstash) 

## Informations
Toutes modifications/suggestions sont les bienvenues ! 
Auteur : Anthony GOURRAUD
