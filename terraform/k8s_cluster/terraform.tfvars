# --------------------- main ---------------------
cloud_id = "b1gndbd7r1pkd7fh847e"

folder_id = "b1gba3nbml1ge13n65vh"

service_account_key_file = "/home/shovel/Downloads/yacloud/key.json"

#=========== network ==============
network_name = "my-ha-net"

# ----------- Kafka ---------------
kafka_zones = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]

# -------------------- Cluster

master_version       = "1.30"
master_region        = "ru-central1"
white_ips_for_master = ["0.0.0.0/0"]

subnets = {
  "k8s_workers" = [
    {
      name = "k8s_worker_zone_a"
      zone = "ru-central1-a"
      cidr = ["10.0.1.0/28"]
    },
    {
      name = "k8s_worker_zone_b"
      zone = "ru-central1-b"
      cidr = ["10.0.2.0/28"]
    },
    {
      name = "k8s_worker_zone_d"
      zone = "ru-central1-d"
      cidr = ["10.0.3.0/28"]
    }
  ]
  "k8s_masters" = [
    {
      name = "k8s_master_zone_a"
      zone = "ru-central1-a"
      cidr = ["10.0.4.0/24"]
    },
    {
      name = "k8s_master_zone_b"
      zone = "ru-central1-b"
      cidr = ["10.0.5.0/24"]
    },
    {
      name = "k8s_master_zone_d"
      zone = "ru-central1-d"
      cidr = ["10.0.6.0/24"]
    }
  ]
}

subnets_default = {
  "mysubnet-a" = {
    name = "mysubnet-a"
    cidr = ["10.5.0.0/16"]
    zone = "ru-central1-a"
  },
  "mysubnet-b" = {
    name = "mysubnet-b"
    cidr = ["10.6.0.0/16"]
    zone = "ru-central1-b"
  },
  "mysubnet-d" = {
    name = "mysubnet-d"
    cidr = ["10.7.0.0/16"]
    zone = "ru-central1-d"
  }
}

node_groups = {
  node-group-a = {
    platform_id    = "standard-v1",
    name           = "worker-a-{instance.short_id}",
    cores          = 2,
    memory         = 2,
    boot_disk_type = "network-ssd",
    boot_disk_size = 32,
    zone           = "ru-central1-a",
    auto_scale = {
      min     = 1,
      max     = 3,
      initial = 1
    }
  }
  node-group-b = {
    platform_id    = "standard-v1",
    name           = "worker-b-{instance.short_id}",
    cores          = 2,
    memory         = 2,
    boot_disk_type = "network-ssd",
    boot_disk_size = 32,
    zone           = "ru-central1-b",
    fixed_scale = {
      size = 1
    }
  }
  node-group-d = {
    platform_id    = "standard-v2",
    name           = "worker-d-{instance.short_id}",
    cores          = 2,
    memory         = 2,
    boot_disk_type = "network-ssd",
    boot_disk_size = 32,
    zone           = "ru-central1-d",
    fixed_scale = {
      size = 1
    }
  }
}

