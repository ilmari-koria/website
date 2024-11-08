xquery version "3.1";
declare option output:method 'html';
declare option output:indent 'yes';

declare variable $dir-publish := file:resolve-path("./publish");
declare variable $dir-org := file:resolve-path("./org");
declare variable $dir-lib := file:resolve-path("./lib");
declare variable $dir-tmp := file:resolve-path("./tmp");

declare function local:el-generate-xml-from-org() {
  let $om-to-xml := $dir-lib || "/el/convert-blog-posts-to-xml.el"
  let $emacs := "emacs"
  let $args := (
    "--batch",
    "-l", $om-to-xml,
    "-f", "convert-blog-posts-to-xml"
  )
  return
    proc:system($emacs, $args, options := { 'dir' : $dir-lib || '/el' }),
    file:list($dir-org, false(), '*.xml') !
    file:move($dir-org || ., $dir-tmp || "/xml/posts"),
    file:move($dir-tmp || "/xml/posts/reading-list.xml", $dir-tmp || "/xml/reading/reading-list.xml")
};

(: TODO this really should be done with bibutils :)
declare function local:generate-bib-html() {
  let $output := $dir-tmp || "/xml/bibliography/bibliography"
  let $input := "./bib/bibliography.bib"
  let $program := "bibtex2html"
  let $args := (
     "--style", 'ieeetr',
     "--footer", '',
     "--header", '',
     "--no-header",
     "--nodoc",
     "--nobibsource",
     "--ignore-errors",
     "--sort-as-bibtex",
     "--output", $output,
     $input
  )
  return
    proc:system($program, $args)
};

declare function local:generate-bib-xml() {
  let $output := $dir-tmp || "/xml/bibliography/bibliography.xml"
  let $input := $dir-tmp || "/xml/bibliography/bibliography.html"
  let $program := "tidy"
  let $args := (
    "-q",
    "--numeric-entities", "yes",
    "-asxhtml",
    "-o", $output,
    $input
  )
  return
    proc:system($program, $args)
};

declare function local:concat-xml-files() {
  let $directory-path := $dir-tmp || "xml/posts/"
  let $output := $dir-tmp || "xml/concat/posts-concat.xml"
  let $concatenated :=
    <root>
      {
        for $file in file:list($directory-path, false(), "*.xml")
        let $doc := fn:doc(concat($directory-path, "/", $file))
        return $doc/*
      }
    </root>
  return
    file:write($output, $concatenated)
};

local:concat-xml-files()

(:
 : local:xsl-create-concat()
 :)

    (:
     : file:write($dir-tmp || "/xml/concat/posts-concat.xml", .)
     :)

(:
 : local:generate-bib-html(),
 : local:generate-bib-xml(),
 : local:el-generate-xml-from-org(),
 :)
(:
 : local:xsl-create-concat()
 :)

(:
 : local:el-generate-xml-from-org()
 :)

(:
 : declare function local:xsl-run-transform() {
 :   let $xsl-archive := $dir-lib || "/xsl/posts.html"
 :   let $xsl-index   := $dir-lib || "/xsl/index.html"
 :   let $xsl-about   := $dir-lib || "/xsl/about.html"
 :   let $xsl-atom    := $dir-lib || "/xsl/atom.xml"
 :   let $xsl-css     := $dir-lib || "/xsl/style.css"
 : 
 :   let $source-concat := $dir-tmp || "/xml/concat/posts-concat.xml"
 : 
 :   return
 :     xslt:transform($source-concat, $xsl-archive),
 :     xslt:transform($source-concat, $xsl-index),
 :     xslt:transform($source-concat, $xsl-about),
 :     xslt:transform($source-concat, $xsl-atom),
 :     xslt:transform($source-concat, $xsl-css)
 : };
 :)

(:
 : local:el-generate-xml-from-posts(),
 :)

