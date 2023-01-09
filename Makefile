default: up

build_up: build up

up: migrate
	docker compose up -d web_app

init: build up

migrate:
	docker compose run --rm web_app bundle exec rails db:migrate

build:
	docker compose build

deploy_production: build_and_push deploy_cloud_run

deploy_cloud_run:
	gcloud run deploy rails-pscale-trial \
	--platform managed \
	--region ${REGION} \
	--image gcr.io/${PROJECT_ID}/rails-pscale-trial \
	--set-env-vars=PROJECT_ID=${PROJECT_ID},DATABASE_HOST=${DATABASE_HOST},DATABASE_NAME=${DATABASE_NAME},RAILS_ENV=production \
	--set-secrets=RAILS_MASTER_KEY=rails-master-key:latest,DATABASE_USERNAME=pscale-db-user:latest,DATABASE_PASSWORD=pscale-db-password:latest \
	--port 3000 \
	--concurrency=5 \
	--max-instances=10 \
	--allow-unauthenticated

create_migrate_production:
	pscale deploy-request create ${DATABASE_NAME} ${BRANCH}

deploy_migrate_production:
	pscale deploy-request deploy ${DATABASE_NAME} ${REQUEST_ID}

build_and_push:
	gcloud builds submit --config cloudbuild.yaml

install_pscale:
	# other ubuntu: https://github.com/planetscale/cli#installation
	wget https://github.com/planetscale/cli/releases/download/v0.126.0/pscale_0.126.0_linux_amd64.deb
	apt install ./pscale_0.126.0_linux_amd64.deb
	rm pscale_0.126.0_linux_amd64.deb
