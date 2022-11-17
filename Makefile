RIP="null"
action:
	RIP=$(filter-out $@,$(MAKECMDGOALS))
commit: action
	git add *
	git commit -m ${RIP}
push: commit
	git push
pull: commit
	git pull
	
