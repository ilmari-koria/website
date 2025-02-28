import module namespace blg = "http://www.ilmarikoria.xyz";
declare variable $publish-path external;

let $posts := collection("posts")//*:document
let $reading-list := collection("org")//*:document[*:headline[@level="1"][@raw-value = "Reading List"]]

let $archive   := file:resolve-path($publish-path || "/posts.html")
let $index     := file:resolve-path($publish-path || "/index.html")
let $about     := file:resolve-path($publish-path || "/about.html")
let $atom      := file:resolve-path($publish-path || "/atom.xml")
let $reading   := file:resolve-path($publish-path || "/reading-list.html")
let $atom-path := file:resolve-path($blg:tmp || "atom.xml")

let $concatenated :=
  <root>
    {
      for $post in $posts
        return $post
    }
   </root>

let $transform-archive :=
 file:write(
   $archive,
   xslt:transform(
     $concatenated,
     $blg:lib || "xsl/archive.xsl",
     { "github-atom-path" : $atom-path })
   )

let $transform-index :=
 file:write(
   $index,
   xslt:transform(
     $concatenated,
     $blg:lib || "xsl/index.xsl",
     { "github-atom-path" : $atom-path })
   )

let $transform-reading :=
 file:write(
   $reading,
   xslt:transform(
     $reading-list,
     $blg:lib || "xsl/reading-list.xsl",
     { "github-atom-path" : $atom-path })
   )

let $transform-atom :=
 file:write(
   $atom,
   xslt:transform(
     $concatenated,
     $blg:lib || "xsl/atom.xsl")
   )

let $transform-about := 
  file:write($about,
  xslt:transform(<dummy/>, $blg:lib || "xsl/about.xsl", { "github-atom-path" : $atom-path })
  )


return (
  fn:message("Generated: " || file:name($archive)),
  $transform-archive,
  fn:message("Generated: " || file:name($index)),
  $transform-index,
  fn:message("Generated: " || file:name($reading)),
  $transform-reading,
  fn:message("Generated: " || file:name($atom)),
  $transform-atom,
  fn:message("Generated: " || file:name($about)),
  $transform-about
  )
