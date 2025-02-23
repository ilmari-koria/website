(:~
 : blog publish functions 
 :
 : @author   ilmarikoria@posteo.net
 : @version  0.2
 :)

module namespace blg = "http://www.ilmarikoria.xyz";

declare variable $blg:lib := file:resolve-path("basex/repo/blog/content/lib");
declare variable $blg:tmp := file:resolve-path("basex/repo/blog/content/lib/tmp/");

declare %private function blg:generate-el(
  $path-to-org-files as xs:string) {
    fn:message("Generating Elisp."),
    file:write($blg:lib || "/el/convert-blog-posts-to-xml.el",
    xslt:transform-text(
      <dummy/>,
      $blg:lib || "/xsl/convert-blog-posts-to-xml.xsl",
      { "org-path" : $path-to-org-files }
  ))
};

declare %public function blg:convert-org(
  $path-to-org-files as xs:string) {
  blg:generate-el($path-to-org-files),
  fn:message("Converting org files."),
  let $args := (
    "--batch",
    "-l", $blg:lib || "/el/convert-blog-posts-to-xml.el",
    "-f", "convert-blog-posts-to-xml"
  )
  return
    proc:system(
      "emacs",
      $args,
      options := { 'dir' : $blg:lib || "/el" }
    )
};

declare %public %updating function blg:update-org-files(
  $path-to-org-files as xs:string) {
  fn:message("Updating org-files"),
  for $file in file:list($path-to-org-files, false(), '*.xml')
    let $path := $path-to-org-files || "/" || $file
    where not(file:is-dir($path))
      return
        if (fn:ends-with($path, "-blog.xml")) then (
          db:put(
            'posts',
             doc($path),
             fn:trace($file, "Adding/updating: ")),
             file:delete(fn:trace($path, "Deleting: "), false())) 
        else (
          db:put(
            'org',
            doc($path),
            fn:trace($file, "Adding/updating: ")),
            file:delete(fn:trace($path, "Deleting: "), false()))
};

declare %public function blg:publish-posts(
  $output-path as xs:string,
  $github-atom as xs:string) {
  let $posts := collection("posts")//*:document
  for $post in $posts
    let $path :=
      $output-path || "/" || fn:substring-after(fn:base-uri($post),"/posts/")
        => fn:replace(".xml", ".html")
     return (
       file:write($path,
       xslt:transform(
         $post,
         $blg:lib || "/xsl/posts.xsl",
         { "github-atom-path" : collection("misc")})
         )
     )
};

declare %public function blg:generate-pdf-with-pdflatex(
  $input-xml,
  $output-dir,
  $tex-path) {
   let $args := (
    "-interaction=batchmode",
    "-output-directory", $output-dir,
    $tex-path
  )
  return (
    fn:message("Generating PDF from: " || fn:base-uri($input-xml)),
    proc:system("pdflatex", $args)
  )
};

declare %private function blg:download-text-file(
  $uri as xs:string,
  $out-path as xs:string) {
  let $response := http:send-request(
    <http:request 
       method='get' 
       href='{$uri}' 
       timeout='10'
       override-media-type='text/plain'/>
  )  
  let $body := tail($response)
  return
    file:write($out-path, html:parse($body))
};
