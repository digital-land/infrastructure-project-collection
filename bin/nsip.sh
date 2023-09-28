#!/bin/sh
{
	grep 'window.markers = ' |
       	sed -e 's/^.*new Array(/[/' \
		-e 's/), function.*$/]/' \
		-e 's/'\''/"/g' \
		-e 's/}, {/},\n{/g'
}
