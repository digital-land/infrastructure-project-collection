#!/usr/bin/env python3

import sys
import html
import re
import json
import csv
from shapely.geometry import Point


def squash(s):
    s = html.unescape(s)
    s = re.sub(r'[^\w\d]', '', s)
    return s.lower()


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

projects = {}

# load scraped data
j = json.load(open(sys.argv[1]))
for o in j:
    projects[squash(o["name"])] = o

for row in csv.DictReader(open(sys.argv[2])):
    n = squash(row["name"])
    if n not in projects:
        print("No project for link:", row["documentation-url"], file=sys.stderr)
    else:
        projects[squash(row["name"])]["documentation-url"] = row["documentation-url"]

for project in projects:
    row = projects[project]
    if not row.get("documentation-url", ""):
        print("Missing documentation-url for project:", row["name"], file=sys.stderr)

w = csv.DictWriter(open(sys.argv[3], "w", newline=""), fieldnames=fieldnames)
w.writeheader()

for project in sorted(projects):
    o = projects[project]
    point = Point((o["lon"], o["lat"])).wkt.replace("POINT ", "POINT")
    row = {
        "name": o["name"],
        "reference": o["prjref"],
        "infrastructure-project-type": o["type"],
        "infrastructure-project-decision": o["stage"],
        "point": point,
        "documentation-url": o.get("documentation-url", ""),
    }
    w.writerow(row)
