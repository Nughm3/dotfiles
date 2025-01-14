#!/usr/bin/env python3

import subprocess, sys, os

try:
    action = sys.argv[1]
except IndexError:
    sys.exit("no action specified")

if not os.path.exists("/tmp/rivertag"):
    with open("/tmp/rivertag", "w") as f:
        f.write("1")

with open("/tmp/rivertag") as f:
    tag = int(f.read())

if action == "set":
    try:
        tag = sys.argv[2]
    except IndexError:
        sys.exit("no tag specified")
else:
    sel = None
    count = 0
    for i in range(10):
        if tag & (1 << i):
            count += 1
            sel = i + 1
    if count > 1:
        sys.exit("multiple tags selected")

    if action == "next" and sel < 9:
        tag <<= 1
    elif action == "previous" and sel > 1:
        tag >>= 1
    else:
        sys.exit("tag out of range or invalid action specified")

try:
    if sys.argv[2] == "drag":
        subprocess.run(["riverctl", "set-view-tags", str(tag)])
except IndexError:
    pass

subprocess.run(["riverctl", "set-focused-tags", str(tag)])
with open("/tmp/rivertag", "w") as f:
    f.write(str(tag))
