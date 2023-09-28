data/nsip.csv: data/nsip.json bin/nsip.py
	python3 bin/nsip.py data/nsip.json $@

data/nsip.json: bin/nsip.sh
	bin/nsip.sh > $@
