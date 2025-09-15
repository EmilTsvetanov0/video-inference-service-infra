locals {
  subnet_array = flatten([for k, v in var.subnets : [for j in v : {
    name = j.name
    zone = j.zone
    cidr = j.cidr
    }
  ]])
}

locals {
  k8s_masters_subnet_info = [for k, v in var.subnets["k8s_masters"] : zipmap(["subnet_id", "zone"], [yandex_vpc_subnet.subnet-main[v.name].id, yandex_vpc_subnet.subnet-main[v.name].zone])]
  k8s_workers_subnet_info = [for k, v in var.subnets["k8s_workers"] : zipmap(["subnet_id", "zone"], [yandex_vpc_subnet.subnet-main[v.name].id, yandex_vpc_subnet.subnet-main[v.name].zone])]
  worker_subnet_list      = zipmap([for subnet in local.k8s_workers_subnet_info : subnet["zone"]], [for subnet in local.k8s_workers_subnet_info : subnet["subnet_id"]])
}