SHELL := /bin/bash

.PHONY: build pagefind

build: public 
public hugo.log: hugo.yml
	@hugo --environment=production --cleanDestinationDir --minify \
		--printI18nWarnings --printPathWarnings --printUnusedTemplates \
        --templateMetrics --templateMetricsHints --logFile=hugo.log

pagefind: public/_pagefind
public/_pagefind: | public
	@pagefind --source public
