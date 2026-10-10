
.PHONY: prepare run restore

prepare:
	mkdir -p "$(QUARANTINE)"

run: prepare
	bash antivirusd.sh "$(DIR)" "$(QUARANTINE)" "$(INTERVAL)"

restore: prepare
	bash restore.sh "$(DIR)" "$(QUARANTINE)"
