resource "google_storage_bucket" "storage" {
  name          = "${var.prefix}-bucket"
  location      = "EU"
  storage_class = "REGIONAL"
  labels        = {}

  versioning {
    enabled = true
  }

  public_access_prevention = "enforced"
  # lifecycle_rule {} I've commented this option, but depending on the needs we can decide how the manage objects inside
  # encryption = {} # Depending on the data stored here, I'd consider using KMS to encrypt this data. I know Google encrypt data at rest, so it all depends on the level of control you want over data
  # logging = {} #Obviously it means setting up a log bucket so I won't do it here, just put it as an option, fyi
}
