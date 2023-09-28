#!/usr/bin/env python3

import sys
import json
import csv
from shapely.geometry import Point

fieldnames = [
    "reference",
    "name",
    "documentation-url",
    "infrastructure-project-type",
    "infrastructure-project-decision",
    "point",
    "entry-date",
    "start-date",
    "end-date",
]

# load scraped data
j = json.load(open(sys.argv[1]))

w = csv.DictWriter(open(sys.argv[2], "w", newline=""), fieldnames=fieldnames)
w.writeheader()

for o in j:
    point = Point((o["lon"], o["lat"])).wkt.replace("POINT ", "POINT")
    row = {
        "name": o["name"],
        "reference": o["prjref"],
        "infrastructure-project-type": o["type"],
        "infrastructure-project-decision": o["stage"],
        "point": point,
    }
    w.writerow(row)
