import module namespace blg = "http://www.ilmarikoria.xyz";
declare variable $path-to-org-files external;
declare variable $publish-path external;

let $posts := collection("posts")//*:document
let $atom-path := $blg:tmp || "atom.xml"
let $atom := blg:download-file("https://github.com/ilmari-koria/website/commits.atom", $atom-path)
let $publish := 
  for $post in $posts
    let $path :=
      $publish-path || "/" || fn:substring-after(fn:base-uri($post),"/posts/")
        => fn:replace(".xml", ".html")
      return (
        file:write($path,
        xslt:transform(
          $post,
          $blg:lib || "/xsl/posts.xsl",
          { "github-atom-path" : $atom-path }))
       )
return (
  $atom,
  $publish
)
