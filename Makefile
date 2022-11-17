commit:
	git add *
	git commit -m $(filter-out $@,$(MAKECMDGOALS))
push: commit
	git push
pull: commit
	git pull
	
