#!/bin/sh

main() {

echo "Starting Graylog variables configuration..."

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

graylog2_conf='/opt/graylog/embedded/cookbooks/graylog/templates/default/graylog.conf.erb'
sed -i -e "s/#elasticsearch_cluster_name = graylog2/elasticsearch_cluster_name = ${ES_CLUSTER_NAME}/" "$graylog2_conf"
sed -i -e "s/#elasticsearch_discovery_zen_ping_multicast_enabled = false/elasticsearch_discovery_zen_ping_multicast_enabled=${ES_MULTICAST_ENABLED}/" "$graylog2_conf"
sed -i -e "s/elasticsearch_discovery_zen_ping_unicast_hosts = <%= @es_nodes %>/elasticsearch_discovery_zen_ping_unicast_hosts = ${ES_CLUSTER_UNICAST_HOSTS}/" "$graylog2_conf"

elasticsearch_conf='/opt/graylog/embedded/cookbooks/graylog/templates/default/elasticsearch.yml.erb'
sed -i -e "s/network.host: <%= @es_host %>/network.host: ${ES_NETWORK_HOST}/" "$elasticsearch_conf"

echo "Graylog initialisation is starting..."
/opt/graylog/embedded/share/docker/my_init

}

main
