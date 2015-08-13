# Logs analysis : "ELKG" setup 
Setup with Docker-compose 

#
## Valid tree
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

## Usage 

### Prerequisite
Make sure you have installed [Docker](https://docs.docker.com/linux/started/) and [Docker-compose](https://docs.docker.com/compose/install/)

### Initialization 
```bash
$ cd <docker_compose_yml_repo>
$ docker-compose up 
 ```

### Stop/Start Elasticsearch, Logstash, Kibana & Graylog containers
* Once you have executed `docker-compose up`, you can stop all the containers :  
```bash
$ cd <docker_compose_yml_repo> 
$ docker-compose stop 
```
* To start the containers, execute this command : 
```bash
$ cd <docker_compose_yml_repo> 
$ docker-compose start 
```
* A faster way is to use the `docker-compose restart` command : 
```bash
$ cd <docker_compose_yml_repo>
$ docker-compose restart 
```

### Services available
* Elasticsearch : http://ip.docker.host:9200/_plugin/head
* Graylog : http://ip.docker.host
* Kibana : http://ip.docker.host:5601

## Configuration

### File: `docker-compose.yml` 
* Ports: you can change the left part of the parameters "ports:"  
  `"<host_port_which_can_be_changed>:9300"` for example
* Volumes: you can change the left part of the parameters "volumes:" 
  `"<host_path_persistant_volume_which_can_be_changed>:/var/graylog"` for example
* For network modes, you can choose between :
```
net: "bridge"
net: "none"
net: "container:[name or id]"
net: "host"
```

### File: `configurations.env` 
You can change the parameters/variables for Graylog, Kibana and Elasticsearch in the file `configurations.env` to fit your configuration. 
If you want to configure mail for Graylog, be careful to remove the "#" and to indicate a public IP for the "web-url" parameter (you can choose `localhost` if you prefer...). 


### Logstash 

#### File: `logstash/logstash.conf` 
The `logstash` folder is linked with the Logstash container. The configuration file `logstash.conf` can be modified as much as you want.  
The configuration file must look like this : 
```
input { 
 ## your inputs here   
}
filter {
 ## any filters 
}
output {  
 gelf { host => "ip.adr.graylog.available" }
 stdout { codec => rubydebug }
 ## other outputs 
}
```
You can control Logstash processes if you have access to the `bash` on the Logstash container. To do so, use the command `docker exec <cont_id> bash` (`docker ps` to get the `<cont_id>`).
Modify `logstash/logstash.conf` on the host machine and restart remotely the Logstash process with : 
 `logstash -f /config-dir/logstash.conf`. 

Example : 
```bash 
dev29-user@dev29-machine:~$ nano logstash/logstash.conf          #### Modifications  
dev29-user@dev29-machine:~$ docker exec -it 3203ed92914d  bash   #### Execute a bash on the container 
      ### We are now on the container and we can handle the Logstash process
root@dev29-machine:/$ logstash -f /config-dir/logstash.conf      
```

#### External Logstash processes 

You can install Logstash on different machines to complete the "ELKG stack".

##### Installation with Docker ([more information here](https://hub.docker.com/_/logstash/))

```bash 
docker run -it --rm logstash logstash -e 'input { heartbeat { } } output { gelf { host => "ip.adr.graylog.here" } } 
```
or 
```bash 
docker run -it --rm -v "$PWD":/config-dir logstash logstash -f /config-dir/logstash.conf 
# (`logstash.conf` file has to be in the current folder)
```  

##### Classic installation 
More information [here](https://www.elastic.co/downloads/logstash) 

## Credits
Logs Analysis for Lyra Network. You are allowed to use and modify as you see fit.
Plus, feel free to suggest any ideas. 

Anthony GOURRAUD

