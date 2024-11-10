xquery version "3.1";
declare option output:method 'html';

declare variable $dir-publish := file:resolve-path("./publish");
declare variable $dir-org := file:resolve-path("./org");
declare variable $dir-lib := file:resolve-path("./lib");
declare variable $dir-tmp := file:resolve-path("./tmp");
declare variable $dir-xml := file:resolve-path("./xml");
declare variable $source-concat := $dir-tmp || "xml/concat/posts-concat.xml";
declare variable $reading-list := $dir-tmp || "xml/reading/reading-list.xml";

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
  file:write($dir-tmp || "html/atom.xml", xslt:transform($source-concat, $dir-lib || "xsl/atom.xsl")),
  file:write($dir-tmp || "html/reading-list.html", xslt:transform($reading-list, $dir-lib || "xsl/reading-list.xsl"))
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
local:concat-xml-files(),
local:xsl-transform-misc(),
local:xsl-transform-posts()