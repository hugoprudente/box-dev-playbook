all:
	ansible-playbook main.yml -i inventory --ask-become-pass -v

pre:
	scripts/bootstrap.sh
	ansible-galaxy install -r requirements.yml --force-with-deps

lint:
	yamllint .
	ansible-lint

dependencies:
	ansible-galaxy install -r requirements.yml --force-with-deps
