all:
	ansible-playbook main.yml -i inventory --ask-become-pass -v

lint:
	yamllint .
	ansible-lint

dependencies:
	ansible-galaxy install -r requirements.yml

all:
	ansible-playbook main.yml -i inventory --ask-become-pass -v