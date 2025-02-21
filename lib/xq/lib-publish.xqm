xquery version "3.1";

(:~
 : blog publish functions 
 : @author   ilmarikoria@posteo.net
 : @version  0.2
 :)

module namespace ik-fn = "http://www.ilmarikoria.xyz";

(: TODO adjust basex config for paths :)
declare variable $ik-fn:dir-org := file:resolve-path("./org");
declare variable $ik-fn:dir-lib := file:resolve-path("./lib");
declare variable $ik-fn:dir-tmp := file:resolve-path("./tmp");
declare variable $ik-fn:dir-xml := file:resolve-path("./xml");
declare variable $ik-fn:source-concat := $ik-fn:dir-tmp || "xml/concat/posts-concat.xml";
declare variable $ik-fn:reading-list := $ik-fn:dir-tmp || "xml/reading/reading-list.xml";

declare function ik-fn:hello-world() {
  let $string := "Hello, World"
  return $string
};

(: TODO convert these into actual functions at some point :)

declare function ik-fn:el-generate-xml-from-org() {
  let $om-to-xml := $ik-fn:dir-lib || "/el/convert-blog-posts-to-xml.el"
  let $emacs := "emacs"
  let $args := (
    "--batch",
    "-l", $om-to-xml,
    "-f", "convert-blog-posts-to-xml"
  )
  return
    proc:system($emacs, $args, options := { 'dir' : $ik-fn:dir-lib || '/el' }),
    file:list($ik-fn:dir-org, false(), '*.xml') !
    file:move($ik-fn:dir-org || ., $ik-fn:dir-tmp || "/xml/posts"),
    file:move($ik-fn:dir-tmp || "/xml/posts/reading-list.xml", $ik-fn:dir-tmp || "/xml/reading/reading-list.xml")
};

declare function ik-fn:concat-xml-files() {
  let $directory-path := $ik-fn:dir-tmp || "xml/posts/"
  let $output := $ik-fn:dir-tmp || "xml/concat/posts-concat.xml"
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

declare function ik-fn:xsl-transform-bibtex() {
  file:write($ik-fn:dir-tmp || "xml/bibliography/bibliography.xml",
  xslt:transform($ik-fn:dir-tmp || "xml/bibtex/bibtex.xml", $ik-fn:dir-lib || "xsl/bibtex.xsl"))
};

declare function ik-fn:xsl-transform-misc() {
  file:write($ik-fn:dir-tmp || "html/posts.html", xslt:transform($ik-fn:source-concat, $ik-fn:dir-lib || "xsl/archive.xsl")),
  file:write($ik-fn:dir-tmp || "html/index.html", xslt:transform($ik-fn:source-concat, $ik-fn:dir-lib || "xsl/index.xsl")),
  file:write($ik-fn:dir-tmp || "html/about.html", xslt:transform($ik-fn:source-concat, $ik-fn:dir-lib || "xsl/about.xsl")),
  file:write($ik-fn:dir-tmp || "html/atom.xml", xslt:transform($ik-fn:source-concat, $ik-fn:dir-lib || "xsl/atom.xsl")),
  file:write($ik-fn:dir-tmp || "html/reading-list.html", xslt:transform($ik-fn:reading-list, $ik-fn:dir-lib || "xsl/reading-list.xsl"))
};  
  
declare function ik-fn:xsl-transform-posts() {
  let $directory-path := $ik-fn:dir-tmp || "xml/posts/"
  let $output := $ik-fn:dir-tmp || "html/"
  for $file in file:list($directory-path, false(), "*.xml")
     let $html-file := $file => replace(".xml",".html") 
     return
       file:write($ik-fn:dir-tmp || "html/" || $html-file,
         xslt:transform($ik-fn:dir-tmp || "xml/posts/" || $file, $ik-fn:dir-lib || "xsl/posts.xsl"))
};

declare function ik-fn:get-github-atom() {
  let $url := "https://github.com/ilmari-koria/website/commits.atom"
  let $response := http:send-request(
    <http:request 
nn       method='get' 
       href='{$url}' 
       timeout='10'
       override-media-type='text/plain'/>
  )  
  let $body := tail($response)
  return
    file:write($ik-fn:dir-tmp || "/xml/github/github.atom", html:parse($body))
};

(: TODO use basex xslt:transform-text :)
declare function ik-fn:xsl-generate-tex() {
  let $java := "java"
  let $saxon := "./bin/saxon/saxon-he-12.5.jar"
  let $args := (
    "-cp",$saxon,
    "net.sf.saxon.Transform",
    "-t",
    "-s:./xml/resume.xml",
    "-xsl:./lib/xsl/resume.xsl",
    "-o:./tmp/tex/ilmari-koria-resume.tex"
  )
  return proc:system($java,$args)
};

declare function ik-fn:tex-generate-pdf() {
  let $tex := $ik-fn:dir-tmp || "tex/ilmari-koria-resume.tex"
  let $pdflatex := "pdflatex"
  let $args := (
    "-interaction=batchmode",
    "-output-directory", $ik-fn:dir-tmp || "html",
    $tex
  )
  return (
    if (exists($tex)) then
      proc:system($pdflatex, $args)
    else
      ".tex file not found."
  )
};  

declare function ik-fn:tex-clean-tmp-files() {
  let $dir := $ik-fn:dir-tmp || "html/"
  for $file in file:list($dir, false())
    let $file-ext := substring-after($file, ".")
    where $file-ext = "aux" or
          $file-ext = "log" or
          $file-ext = "out" or
          $file-ext = "tex"
    return
      if (exists($dir || $file)) then
        file:delete($dir || $file)
      else
        $dir || $file || " not found."
};








