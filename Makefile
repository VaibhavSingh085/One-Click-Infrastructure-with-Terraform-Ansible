
.PHONY: validate plan deploy up down

validate:
	cd terraform && terraform init
	cd terraform && terraform validate
	cd ansible && ansible-playbook --syntax-check site.yml

plan:
	cd terraform && terraform init
	cd terraform && terraform plan

deploy:
	cd ansible && ansible-playbook site.yml

up:
	cd terraform && terraform init
	cd terraform && terraform validate
	cd terraform && terraform plan
	cd terraform && terraform apply
	@echo "Waiting for SSH connectivity..."
	@ready=0; \
	for i in $$(seq 1 30); do \
		if (cd ansible && ansible web -m ansible.builtin.ping); then \
			ready=1; \
			break; \
		fi; \
		sleep 10; \
	done; \
	if [ "$$ready" -ne 1 ]; then \
		echo "ERROR: Target did not become reachable within 5 minutes."; \
		exit 1; \
	fi
	cd ansible && ansible-playbook site.yml
	@IP=$$(cd terraform && terraform output -raw public_ip) && \
	echo "" && \
	echo "Deployment tasks completed." && \
	echo "Website: http://$$IP/listings" && \
	echo "Confirm the website in your browser."

down:
	cd terraform && terraform destroy

