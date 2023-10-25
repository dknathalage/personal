resource "google_container_cluster" "default" {
  name     = "workload-cluster"
  location = local.node_locations[0]

  remove_default_node_pool = true
  initial_node_count       = 1

  node_locations = []
}

resource "google_container_node_pool" "default" {
  name     = "workload-pool"
  location = local.node_locations[0]
  cluster  = google_container_cluster.default.name

  node_locations = [
    local.node_locations[0]
  ]

  initial_node_count = 1
  autoscaling {
    min_node_count = 1
    max_node_count = 2
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = true
    machine_type = "e2-small"
    disk_size_gb = 10
    disk_type    = "pd-standard"
  }
}
