#!/bin/sh

main() {

echo "Starting..."
ES_CLUSTER_UNICAST_HOSTS=${ES_CLUSTER_UNICAST_HOSTS:-127.0.0.1:9300}
ES_CLUSTER_NAME=${ES_CLUSTER_NAME:-graylog-prod}
ES_NETWORK_HOST=${ES_NETWORK_HOST:-127.0.0.1}
ES_NODE_NAME=${ES_NODE_NAME:-graylog-server}
ES_MULTICAST_ENABLED=${ES_MULTICAST_ENABLED:-false}

echo "ES_CLUSTER_UNICAST_HOSTS=${ES_CLUSTER_UNICAST_HOSTS}"
echo "ES_CLUSTER_NAME=${ES_CLUSTER_NAME}"
echo "ES_NETWORK_HOST=${ES_NETWORK_HOST}"
echo "ES_NODE_NAME=${ES_NODE_NAME}"
echo "ES_MULTICAST_ENABLED=${ES_MULTICAST_ENABLED}"

echo "Installing elasticsearch-head plugin... "
/usr/share/elasticsearch/bin/plugin -install -DproxyHost=192.168.100.1 -DproxyPort=80 mobz/elasticsearch-head

echo "Starting Elasticsearch with configured parameters..."
elasticsearch --node.name=${ES_NODE_NAME} --cluster.name=${ES_CLUSTER_NAME} --network.publish_host=${ES_NETWORK_HOST} --discovery.zen.ping.multicast.enabled=${ES_MULTICAST_ENABLED} --discovery.zen.ping.unicast.hosts=${ES_CLUSTER_UNICAST_HOSTS}

}

main
