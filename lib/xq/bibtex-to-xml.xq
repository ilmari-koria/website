xquery version "3.1";

declare namespace saxon = "http://saxon.sf.net/";
declare namespace b = "http://ilmarikoria.xyz/bib";
declare option saxon:output "indent=yes";
declare variable $bibtex := fn:unparsed-text("../../bib/bibliography.bib");

declare function b:bibtex-to-json($bibtex as xs:string) as element()* {
    for $entry in tokenize($bibtex, "\n@")
    let $entry := fn:normalize-space($entry)
    let $type := substring-before($entry, "{")
    let $citation-key := substring-before(substring-after($entry, "{"), ",")
    let $fields := 
        for $field in tokenize(substring-after($entry, "{"), ",") 
        return
            let $key := fn:normalize-space(substring-before($field, "="))
            let $value := fn:normalize-space(substring-after($field, "="))
            return 
                if (string-length($key) > 0) then
                    if (starts-with($value, "{")) then
                        element { $key } { fn:substring-before(fn:substring-after($value, "{"), "}") }
                    else
                        element { $key } { fn:substring-before(fn:substring-after($value, "'"), "'") }
                else
                    ()
        return 
        	<entry type="{$type}" key="{$citation-key}">
        	    {$fields}      
        	</entry>
};

let $json := b:bibtex-to-json($bibtex)
return
	<bib>
	  {$json}
	</bib>