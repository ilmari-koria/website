(:~
 : blog publish functions 
 :
 : @author   ilmarikoria@posteo.net
 : @version  0.2
 :)

module namespace blg = "http://www.ilmarikoria.xyz";

declare variable $blg:lib := file:resolve-path("basex/repo/blog/content/lib");

declare %private function blg:generate-el(
  $path-to-org-files as xs:string) {
    file:write($blg:lib || "/el/convert-blog-posts-to-xml.el",
    xslt:transform-text(
      <dummy/>,
      $blg:lib || "/xsl/convert-blog-posts-to-xml.xsl",
      { "org-path" : $path-to-org-files }
  ))
};

declare %private function blg:convert-org(
  $path-to-org-files as xs:string) {
  blg:generate-el($path-to-org-files),
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

declare %public function blg:update-org-files(
  $path-to-org-files as xs:string) {
  for $file in file:list($path-to-org-files, false(), '*.xml')
    let $path := $path-to-org-files || $file
    where not(file:is-dir($path))
      return
        db:put('org', doc($path), $file),
        file:delete($path)
};