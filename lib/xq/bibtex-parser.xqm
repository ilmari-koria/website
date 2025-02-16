xquery version "3.1";

(:~
 : crappy bibtex to xml converter
 : @author   ilmarikoria@posteo.net
 : @version  0.1
 :)

module namespace ik-bib = "http://www.ilmarikoria.xyz/bibtex";

declare function ik-bib:bibtex-read-file-and-tokenize($bibtex-file-path) {
  let $bibtex := unparsed-text($bibtex-file-path)
  let $bibtex-clean := replace($bibtex, '&amp;', '&amp;amp;')
  for $line in tokenize($bibtex-clean, "\n")
    return
    if ($line ne "") then
      $line
    else ()
};

declare function ik-bib:bibtex-replace-first-bracket($bibtex-line) {
  for $line in $bibtex-line
  return
    if (starts-with($line, "@") and contains($line, "{")) then
      replace($line, "\{", " key = ")
    else 
      $line
};

declare function ik-bib:bibtex-replace-brackets($bibtex-line) {
  for $line in $bibtex-line
  return
    if (contains($line, "{") and contains($line, "}")) then
      replace($line, "\{|\}", "")
    else if (ends-with($line, "}")) then
      replace($line, "\}", "")
    else
      $line
};

declare function ik-bib:bibtex-rm-trailing-commas($bibtex-line) {
  for $line in $bibtex-line
    return $line
      => replace(',(\s*)$', ' ')
      => replace(',\s*"', '"')
};

declare function ik-bib:bibtex-add-quotes($bibtex-line) {
  for $line in $bibtex-line
    let $line-split := tokenize($line, ' = ')
    return
      if (count($line-split) = 2) then
        $line-split[1] || ' = "' || $line-split[2] || '"'
      else
        $line
};

declare function ik-bib:bibtex-add-angle-brackets($bibtex-line) {
  for $line in $bibtex-line
    return
      if (starts-with($line, "@")) then
        "<" || $line
      else if (ends-with($line, ',"')) then
        $line
      else if ($line eq "") then
        ""      
      else
        $line || " />"
};

declare function ik-bib:bibtex-replace-at-symbol($bibtex-line) {
  for $line in $bibtex-line
    return
      replace($line, "<@","<")
};

declare function ik-bib:bibtex-delete-empty-lines($bibtex-line) {
  for $line in $bibtex-line
    return
      if ($line ne "") then
        $line
      else ()
};

declare function ik-bib:bibtex-wrap-xml-and-write($bibtex-line) {
  let $string-xml := "&lt;bibtex&gt;" || $bibtex-line || "&lt;/bibtex&gt;"
  let $out-path := "./tmp/xml/bibtex/bibtex.xml"
  let $parsed-xml := parse-xml($string-xml)
   return 
     file:write($out-path, $parsed-xml)
};

(: TODO this workflow really needs to be re-done :)
declare function ik-bib:bibtex-call-functions() {
  let $bibtex-file-path := "../../bibtex/bibliography.bib"
  return
    ik-bib:bibtex-read-file-and-tokenize($bibtex-file-path)
      => ik-bib:bibtex-replace-first-bracket()
      => ik-bib:bibtex-replace-brackets()
      => ik-bib:bibtex-add-quotes()
      => ik-bib:bibtex-add-angle-brackets()
      => ik-bib:bibtex-rm-trailing-commas()
      => ik-bib:bibtex-replace-at-symbol()
      => ik-bib:bibtex-delete-empty-lines()
      => ik-bib:bibtex-wrap-xml-and-write()
};
