commit:
	git add *
	git commit -m $(filter-out $@,$(MAKECMDGOALS))
push:
	git add *
	git commit -m $(filter-out $@,$(MAKECMDGOALS))
	git push
pull:
	git add *
	git commit -m $(filter-out $@,$(MAKECMDGOALS))
	git pull
	
