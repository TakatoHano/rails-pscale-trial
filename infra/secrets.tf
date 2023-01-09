
# Step:2 ecncrypt secrets: rails_master_key, pscale_db_user, pscale_db_password
# Must Replace!: echo -n $RAILS_MASTER_KEY | gcloud kms encrypt --location asia-northeast1 --keyring ring1 --key crypto1 --plaintext-file - --ciphertext-file - | base64
data "google_kms_secret" "rails_master_key" {
  crypto_key = google_kms_crypto_key.crypto_key.id
  ciphertext = "CiQAI+Qsv2+dkB0kIw2/EnDFWDIFz6R7VFcfkSfram2xwPp4p1ISSQAEeTQ+wbwH+iNANGrOtD2ujFk0DfbJR353drhiimSD2AsjvHnNrYqEU1H6S7uJkUkDWljRtWv6A+AAMTwKJ+XYDV97r2m211I="
}

data "google_kms_secret" "pscale_db_user" {
  crypto_key = google_kms_crypto_key.crypto_key.id
  ciphertext = "CiQAI+Qsv7VP0Q7RljAC3VcRU2w4eXhMZqZYaADsWR+fxm6FNFgSPQAEeTQ+snyDbJhfWNyJp1sRNJMgijSOXXiV4QPt+RpNDc1fAOQkFfmmLnbRPBhOLXu3ZpV2QvpC3Z5gMh8="
}

data "google_kms_secret" "pscale_db_password" {
  crypto_key = google_kms_crypto_key.crypto_key.id
  ciphertext = "CiQAI+Qsv7QfIhk4DNitd3TbRr4sJBJwWyTTmNK4eh4SUQ71NdISXgAEeTQ+SKxM5TfmP0VWXbSpc2v5OwbVdmDiwMQl8mh2eXLkPnXvOjGt89edmM9IoSHxjJDnxQW8Yo/Sgd0vD5BJNKVJyyL4suO450o5r9LQY0AhUN3iW8C0+UcWSgo="
}


module "secrets" {
  source     = "./modules/secrets"
  project_id = data.google_project.default.project_id
  secrets = {
    "rails-master-key"   = data.google_kms_secret.rails_master_key.plaintext
    "pscale-db-user"     = data.google_kms_secret.pscale_db_user.plaintext
    "pscale-db-password" = data.google_kms_secret.pscale_db_password.plaintext
  }
}
