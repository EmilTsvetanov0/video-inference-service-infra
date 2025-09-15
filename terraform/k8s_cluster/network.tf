resource "yandex_vpc_network" "my-ha-net" {
  name = var.network_name
}

resource "yandex_vpc_gateway" "nat_gateway" {
  name      = "nat-gateway"
  folder_id = var.folder_id
}

resource "yandex_vpc_route_table" "nat_route_table" {
  name       = "nat-route-table"
  network_id = yandex_vpc_network.my-ha-net.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

resource "yandex_vpc_subnet" "subnet-main" {
  for_each = {
    for k, v in local.subnet_array : "${v.name}" => v
  }
  network_id     = yandex_vpc_network.my-ha-net.id
  v4_cidr_blocks = each.value.cidr
  zone           = each.value.zone
  name           = each.value.name
  route_table_id = yandex_vpc_route_table.nat_route_table.id
}

