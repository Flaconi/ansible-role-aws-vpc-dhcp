###
### Variables
###
ANSIBLE_VERSION=2.5-aws


###
### Default
###
help:
	@printf "%s\n\n" "Available commands"
	@printf "%s\n"   "make test             Test the Ansible role"
	@printf "%s\n"   "make lint             Lint source files"
	@printf "%s\n"   "make help             Show help"

test:
	docker run --rm -it \
		-v ${PWD}:/etc/ansible/roles/rolename \
		--workdir /etc/ansible/roles/rolename/tests \
		-e AWS_ACCESS_KEY \
		-e AWS_SECRET_KEY \
		flaconi/ansible:${ANSIBLE_VERSION} ./support/run-tests.sh

lint:
	yamllint .
