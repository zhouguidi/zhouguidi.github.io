dt = $(shell date)
build:
	jekyll build
	./page_per_tag.sh
	jekyll build

publish:
	git add -A
	git commit -m "$(dt)"
	git push
