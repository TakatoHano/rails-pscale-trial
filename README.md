# README

Sample rails app use [PlanetScale](https://planetscale.com/)
See Official Doc: https://planetscale.com/docs/tutorials/connect-rails-app

# Versions
## - Ruby version: 3.1.3 (Rails 7.0.4)
## - Terraform version: 1.2.9 (google 4.36.0)
## - [PlanetScale CLI](https://github.com/planetscale) version: 0.126.0

# For Develop
## Set Env
```sh
# for terraforn and gcloud cli
export GOOGLE_APPLICATION_CREDENTIALS=YOUR_CREDENTIAL
export GOOGLE_PROJECT=YOUR_PROJECT
export PROJECT_ID=$GOOGLE_PROJECT
# Recommend a region that is close to the corresponding region of Planet Scale
export REGION=asia-northeast1
export RAILS_MASTER_KEY=`cat config/master.key | tr -d \n `
# Planet Scale`s ENV(from your develop branch)
export RAILS_MASTER_KEY
export DATABASE_NAME
export DATABASE_USERNAME
export DATABASE_HOST
export DATABASE_PASSWORD
```
## Start Service(local): `make (up) `
---
# Create GCP Recources
## Create resource by Terraform
### Run on infra dir
```sh
cd infra && make init
```

### 1. Comment out secret resources(infra/secrets.tf)

### 2. Create resource exclude secret
```sh
make plan
make apply -auto-approve
```
### 3. Encrypt your production secrets: rails_master_key, pscale_db_user, pscale_db_password
e.g)
```sh
echo -n $RAILS_MASTER_KEY | gcloud kms encrypt --location asia-northeast1 --keyring ring1 --key crypto1 --plaintext-file - --ciphertext-file - | base64
```
### 4. Set google_kms_secret, and uncomment
e.g)
```hcl
data "google_kms_secret" "rails_master_key" {
  crypto_key = google_kms_crypto_key.crypto_key.id
  # Must Replace!: echo -n $RAILS_MASTER_KEY | gcloud kms encrypt --location asia-northeast1 --keyring key-ring --key crypto-key --plaintext-file - --ciphertext-file - | base64
  ciphertext = ### Here! ###
}
```
### 5. Create secret
```sh
make
make apply -auto-approve
```

## Deploy App to GCP Cloud Run
### Create and Deploy Migrate on PlanetScale
```sh
make create_migrate_production BRANCH={YOUR_DEVELOP_BRANCH}
make deploy_migrate_production REQUEST_ID={ABOVE_REQUEST_ID}
```
### Deploy(image build & push -> service deploy)
```sh
make deploy_production
```
