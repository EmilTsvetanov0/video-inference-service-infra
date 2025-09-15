output "k8s_cluster_id" {
  value = yandex_kubernetes_cluster.k8s-ha-three-zones.id
}

# output "kafka_brokers" {
#   value = join(",", [for broker in yandex_mdb_kafka_cluster.video_cluster.host : "${broker}:9091"])
# }