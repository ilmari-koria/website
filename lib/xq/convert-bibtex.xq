xquery version "3.1";

declare option output:indent "yes";
declare variable $bibtex := fn:unparsed-text("../../bib/bibliography.bib");


declare function local:clean-bibtex($bibtex) {
  let $cleaned-entry-lines := 
    for $line in tokenize($bibtex, "\n") 
      let $line := normalize-space($line)
        => replace("\}", "")
      return $line
  return $cleaned-entry-lines
};

for $x in local:clean-bibtex($bibtex)
return $x



       (:
        : if (contains($line, "@")) then
        :       replace($line, "@", "") =>
        :         replace("\{", "") =>
        :         replace("\}", "")
        :     else
        :         replace($line, "\{", "") =>
        :         replace("\}", "")
        :)