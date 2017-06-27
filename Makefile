agda := $(wildcard src/*.lagda)
agdai := $(wildcard src/*.agdai)
markdown := $(subst src/,out/,$(subst .lagda,.md,$(agda)))

default: $(markdown)

out/:
	mkdir out

out/%.md: src/%.lagda out/
	agda2html --verbose --link-to-agda-stdlib --link-local -i $< -o $@

.phony: serve

serve:
	ruby -S gem install bundler --no-ri --no-rdoc
	ruby -S bundle install
	ruby -S bundle exec jekyll serve

.phony: clean

clean:
ifneq ($(strip $(agdai)),)
	rm $(agdai)
endif

.phony: clobber

clobber: clean
	ruby -S gem install bundler --no-ri --no-rdoc
	ruby -S bundle install
	ruby -S bundle exec jekyll clean
ifneq ($(strip $(markdown)),)
	rm $(markdown)
endif
	rmdir out/