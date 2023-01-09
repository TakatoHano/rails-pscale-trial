# Activate These APIs!
# cloud run
# cloud build
# secret manager
# kms

# secret: rails-master-key encrypt by kms
# Step:1 create kms
resource "google_kms_key_ring" "key_ring" {
  project  = data.google_project.default.project_id
  name     = "ring1"
  location = "asia-northeast1"
}

resource "google_kms_crypto_key" "crypto_key" {
  name     = "crypto1"
  key_ring = google_kms_key_ring.key_ring.id
}

resource "google_project_iam_member" "cloud_run_sa_secret_access" {
  project = data.google_project.default.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${data.google_project.default.number}-compute@developer.gserviceaccount.com"
}
