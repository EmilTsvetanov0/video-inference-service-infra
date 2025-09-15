resource "yandex_kubernetes_cluster" "k8s-ha-three-zones" {
  name       = "k8s-ha-three-zones"
  network_id = yandex_vpc_network.my-ha-net.id
  master {
    public_ip = var.master_public_ip

    dynamic "master_location" {
      for_each = local.k8s_masters_subnet_info
      content {
        zone      = master_location.value["zone"]
        subnet_id = master_location.value["subnet_id"]
      }
    }

    security_group_ids = [yandex_vpc_security_group.internal.id, yandex_vpc_security_group.k8s_master.id]
  }
  service_account_id      = yandex_iam_service_account.ha-k8s-account.id
  node_service_account_id = yandex_iam_service_account.ha-k8s-account.id
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
    yandex_resourcemanager_folder_iam_member.editor,
    yandex_resourcemanager_folder_iam_member.vpc-public-admin,
    yandex_resourcemanager_folder_iam_member.images-puller,
    yandex_resourcemanager_folder_iam_member.encrypterDecrypter
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }
  release_channel = "STABLE"
}

resource "yandex_kms_symmetric_key" "kms-key" {
  # A Yandex Key Management Service key for encrypting critical information, including passwords, OAuth tokens, and SSH keys.
  name              = "kms-key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" # 1 year.
}
