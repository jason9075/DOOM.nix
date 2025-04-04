DEFAULT_GOAL:=help


.PHONY: run
run:
	@fd . | entr -r sh -c 'cd linuxdoom-1.10 && make && cd ../scripts && ./launch_game.sh'

.PHONY: build
build:
	@cd linuxdoom-1.10 && make


.PHONY: clean
clean:
	@cd linuxdoom-1.10 && make clean

.PHONY: help
help:
	@echo "Makefile for local development"
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m (default: help)\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-18s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
