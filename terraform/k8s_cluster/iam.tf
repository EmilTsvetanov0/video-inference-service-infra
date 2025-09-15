resource "yandex_iam_service_account" "ha-k8s-account" {
  name        = "ha-k8s-account"
  description = "Service account for the highly available Kubernetes cluster"
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.ha-k8s-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
  # The service account gets the "k8s.clusters.agent" role.
  folder_id = var.folder_id
  role      = "k8s.clusters.agent"
  member    = "serviceAccount:${yandex_iam_service_account.ha-k8s-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
  # The service account gets the "vpc.publicAdmin" role.
  folder_id = var.folder_id
  role      = "vpc.publicAdmin"
  member    = "serviceAccount:${yandex_iam_service_account.ha-k8s-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
  # The service account gets the "container-registry.images.puller" role.
  folder_id = var.folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.ha-k8s-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "encrypterDecrypter" {
  # The service account gets the "kms.keys.encrypterDecrypter" role.
  folder_id = var.folder_id
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:${yandex_iam_service_account.ha-k8s-account.id}"
}