data/nsip.csv: data/nsip.json data/nsip-links.csv bin/nsip.py
	python3 bin/nsip.py data/nsip.json data/nsip-links.csv $@

data/nsip-links.csv: var/cache/nsip.html bin/nsip-links.sh
	bin/nsip-links.sh < var/cache/nsip.html > $@

data/nsip.json: var/cache/nsip.html bin/nsip.sh
	bin/nsip.sh < var/cache/nsip.html > $@

var/cache/nsip.html:
	@mkdir -p var/cache/
	curl -s 'https://infrastructure.planninginspectorate.gov.uk/projects/' > $@

clobber::
	# rm -f data/nsip.csv data/nsip.json
