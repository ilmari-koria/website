#!/bin/bash
BASEX="./basex/bin/basex"
BASEX_DIR="./basex"
# note this needs to be an absolute path
ORG_FILES="/home/ilmari/my-files/website/org"
PUBLISH_DIR="./publish"
BIBTEX="./bibtex"

bibtex2html --style "ieeetr" --footer "" --header "" --no-header --nodoc --nobibsource --ignore-errors --sort-as-bibtex --output $BIBTEX/bibliography $BIBTEX/bibliography.bib
tidy -q --numeric-entities yes -asxhtml -o $BIBTEX/bibliography.xml $BIBTEX/bibliography.html

$BASEX -bpath-to-org-files=$ORG_FILES \
       -bpublish-path=$PUBLISH_DIR \
       -c $BASEX_DIR/repo/blog/content/publish.bxs

rm $BIBTEX/bibliography.xml $BIBTEX/bibliography.html
rm $PUBLISH_DIR/*.log $PUBLISH_DIR/*.out $PUBLISH_DIR/*.aux

rsync -avz --delete $PUBLISH_DIR/ root@ilmarikoria.xyz:/var/www/ilmarikoria/
sitemap-generator -l https://ilmarikoria.xyz
rsync -avz --delete sitemap.xml root@ilmarikoria.xyz:/var/www/ilmarikoria/sitemap.xml

rm ./sitemap.xml
