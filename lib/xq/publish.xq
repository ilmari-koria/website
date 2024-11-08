xquery version "3.1";
declare option output:method 'html';

declare variable $dir-publish := file:resolve-path("./publish");
declare variable $dir-org := file:resolve-path("./org");
declare variable $dir-lib := file:resolve-path("./lib");
declare variable $dir-tmp := file:resolve-path("./tmp");
declare variable $source-concat := $dir-tmp || "/xml/concat/posts-concat.xml";

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

declare function local:xsl-transform-misc() {
  file:write($dir-tmp || "html/archive.html", xslt:transform($source-concat, $dir-lib || "xsl/archive.xsl")),
  file:write($dir-tmp || "html/index.html", xslt:transform($source-concat, $dir-lib || "xsl/index.xsl")),
  file:write($dir-tmp || "html/about.html", xslt:transform($source-concat, $dir-lib || "xsl/about.xsl")),
  file:write($dir-tmp || "html/atom.xml", xslt:transform($source-concat, $dir-lib || "xsl/atom.xsl"))
};  
  
declare function local:xsl-transform-posts() {
  let $directory-path := $dir-tmp || "xml/posts/"
  let $output := $dir-tmp || "html/"
  for $file in file:list($directory-path, false(), "*.xml")
     let $html-file := $file => replace(".xml",".html") 
     return
       file:write($dir-tmp || "html/" || $html-file,
         xslt:transform($dir-tmp || "xml/posts/" || $file, $dir-lib || "xsl/posts.xsl"))
};

local:el-generate-xml-from-org(),
local:xsl-transform-posts()
