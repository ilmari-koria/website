#!/bin/bash
BASEX="./basex/bin/basex"
PUBLISH="./publish.xq"
ORG_FILES="/home/ilmari/my-files/website/org"
$BASEX -bpath-to-org-files=$ORG_FILES $PUBLISH
