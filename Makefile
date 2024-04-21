default: help

help:
	@echo "usage:"
	@echo "	make start			Start instance"
	@echo "	make stop			Stop instance"
	@echo "	make output			Get Terraform output"

start:
	$(eval INSTANCE_ID := $(shell cd aws && terraform output -raw instance_id))
	( cd aws && aws ec2 start-instances --instance-ids $(INSTANCE_ID) )

stop:
	$(eval INSTANCE_ID := $(shell cd aws && terraform output -raw instance_id))
	( cd aws && aws ec2 stop-instances --instance-ids $(INSTANCE_ID) )

output:
	( cd aws && terraform output )

