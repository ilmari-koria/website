import module namespace blg = "http://www.ilmarikoria.xyz";
declare variable $publish-path external;

let $posts := collection("posts")//*:document
let $reading-list := collection("org")//*:document[*:headline[@level="1"][@raw-value = "Reading List"]]

let $archive := $publish-path || "/posts.html"
let $index := $publish-path || "/index.html"
let $about := $publish-path || "/about.html"
let $atom := $publish-path || "/atom.xml"
let $reading := $publish-path || "/reading-list.html"

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
     $blg:lib || "xsl/archive.xsl")
   )

let $transform-index :=
 file:write(
   $index,
   xslt:transform(
     $concatenated,
     $blg:lib || "xsl/index.xsl")
   )

let $transform-reading :=
 file:write(
   $reading,
   xslt:transform(
     $reading-list,
     $blg:lib || "xsl/reading-list.xsl")
   )


return (
  fn:message("Generated: " || file:name($archive)),
  $transform-archive,
  fn:message("Generated: " || file:name($index)),
  $transform-index,
  fn:message("Generated: " || file:name($reading)),
  $transform-reading
  )
