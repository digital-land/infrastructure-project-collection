#!/bin/bash
#
#<li  id="menu-item-4019127" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-4019127 nav-item"><a itemprop="url" href="https://infrastructure.planninginspectorate.gov.uk/projects/east-midlands/beacon-fen-energy-park/" class="dropdown-item"><span itemprop="name">Beacon Fen Energy Park</span></a></li>
#<li  id="menu-item-4015826" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-4015826 nav-item"><a itemprop="url" href="https://infrastructure.planninginspectorate.gov.uk/help/contact-us/" class="dropdown-item"><span itemprop="name">Contact</span></a></li>

echo "documentation-url,name"

grep ' menu-item-object-page '|
	grep '/projects/' |
	sed -e 's/^.*"url" href="//' \
	    -e 's/" class="dropdown-item"><span itemprop="name">/,"/' \
	    -e 's/<\/span.*$/"/' |
	grep -v 'id="menu-item' |
	grep -v 'projects/register-of-applications/'
