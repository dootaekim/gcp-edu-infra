resource "google_compute_instance" "create_instance" {
    name            =   var.instance_name
    machine_type    =   var.machine_type
    zone            =   var.instance_zone

    tags    =   var.instance_network_tags
    boot_disk {
        initialize_params {
            image   =   var.image_name
            type    =   "pd-standard"
            size    =   80
        }
    }

    network_interface {
        subnetwork  =   var.instance_subnetwork
    }

    service_account {
        email   =   var.service_account
        scopes  =   ["cloud-platform"]
    }

    allow_stopping_for_update = true

    lifecycle {
        ignore_changes = [ attached_disk ]
    }
}

output "instance_self_link" {
    value = google_compute_instance.create_instance.self_link
}