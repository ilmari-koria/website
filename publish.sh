#!/bin/bash
BASEX="./basex/bin/basex"
ORG_FILES="~/my-files/website/org"
PUBLISH_DIR="./publish"
BIBTEX="./bibtex"
XQ="./xq"
$BASEX -bpath-to-org-files=$ORG_FILES $XQ/convert-org-files.xq
$BASEX -bpath-to-org-files=$ORG_FILES $XQ/update-org-files.xq
bibtex2html --style "ieeetr" --footer "" --header "" --no-header --nodoc --nobibsource --ignore-errors --sort-as-bibtex --output $BIBTEX/bibliography $BIBTEX/bibliography.bib
tidy -q --numeric-entities yes -asxhtml -o $BIBTEX/bibliography.xml $BIBTEX/bibliography.html
$BASEX -bpublish-path=$PUBLISH_DIR $XQ/transform-org-files-and-publish.xq
rm $BIBTEX/bibliography.xml $BIBTEX/bibliography.html
$BASEX -bpublish-path=$PUBLISH_DIR $XQ/publish-static-pages.xq
$BASEX -bpublish-path=$PUBLISH_DIR $XQ/generate-resume.xq
