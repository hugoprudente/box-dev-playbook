CLOUDFORMATION_DIR = templates/cloudformation/

lint:
	~/.local/bin/ansible-lint -x 204 -x 403 playbook.yml
	$(foreach file, $(wildcard $(CLOUDFORMATION_DIR)/*), ~/.local/bin/cfn-lint $(file);)

format:
	echo "test"