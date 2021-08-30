.POSIX:

default: book

.PHONY: diagrams
diagrams:
	cd diagrams \
		&& python3 -m venv .venv \
		&& pip3 install -r requirements.txt \
		&& python3 *

.PHONY: book
book:
	mdbook build .

.PHONY: deploy
deploy: book
	@echo "====> deploying to github"
	git worktree add /tmp/book gh-pages
	rm -rf /tmp/book/*
	cp -rp book/* /tmp/book/
	cd /tmp/book && \
		git add -A && \
		git commit -m "Updates" && \
		echo "PUSHING"
	git worktree remove gh-pages
