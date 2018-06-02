variable "region" {
  default = "europe-west1-d" // We're going to need it in several places in this config
}
 
provider "google" {
  credentials = "${file("login_detail.json")}"
  project     = "master-charmer-198216"
  region      = "${var.region}"
}
 
resource "google_compute_firewall" "allow-http" {  
    name = "allow-http"
    network = "default"

    allow {
        protocol = "tcp"
        ports = ["80"]
    }

    source_ranges = ["0.0.0.0/0"]
    target_tags = ["http"]
}

resource "google_compute_instance" "test" {
  count        = 1 // Adjust as desired
  name         = "jupyter-cloud-demo" 
  machine_type = "n1-standard-4" // f1-micro
  zone         = "${var.region}" // yields "europe-west1-d" as setup previously. Places your VM in Europe

  tags = ["http"]
 
 boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1604-lts"
    }
  }
 
  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP - leaving this block empty will generate a new external IP and assign it to the machine
    }
  }

  metadata_startup_script = "${file("start-up-script.sh")}"

}