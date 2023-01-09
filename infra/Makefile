default: fmt plan

init:
	terraform init

fmt:
	terraform fmt

plan:
	terraform plan ${FLAG}

apply:
	terraform apply ${FLAG}

destroy:
	terraform destroy

enc:
	echo -n ${PLAIN} | gcloud kms encrypt --location asia-northeast1 --keyring ring1 --key crypto1 --plaintext-file - --ciphertext-file - | base64 -w 0


.PHONY: enc
