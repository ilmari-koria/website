import module namespace blg = "http://www.ilmarikoria.xyz";
declare variable $path-to-org-files external;

let $xml := collection("resume")
let $out := "/home/ilmari/my-files/website/publish"
return
blg:generate-resume($xml,$out)
