#!/bin/sh
{
curl -s 'https://infrastructure.planninginspectorate.gov.uk/projects/' |
	grep 'window.markers = ' |
       	sed -e 's/^.*new Array(/[/' \
		-e 's/), function.*$/]/' \
		-e 's/'\''/"/g' \
		-e 's/}, {/},\n{/g'
}
