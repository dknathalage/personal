resource "google_container_cluster" "default" {
  name     = "workload-cluster"
  location = local.gcp_region

  remove_default_node_pool = true
  initial_node_count       = 1

  node_locations = []
}

resource "google_container_node_pool" "default" {
  name     = "workload-pool"
  location = local.gcp_region
  cluster  = google_container_cluster.default.name

  node_locations = []

  initial_node_count = 1
  autoscaling {
    min_node_count = 1
    max_node_count = 1
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = true
    machine_type = "e2-micro"
    disk_size_gb = 10
    disk_type    = "pd-standard"
  }
}
