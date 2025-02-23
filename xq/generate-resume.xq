import module namespace blg = "http://www.ilmarikoria.xyz";
declare variable $publish-path external;
declare variable $input-xml := collection("resume");

let $tex-out-path :=
  $blg:tmp || "ilmari-koria-resume.tex"
let $generate-resume-tex :=
  file:write($tex-out-path,
  xslt:transform-text(
    $input-xml,
    $blg:lib || "/xsl/resume.xsl"),
    { 'method': 'text' })
return (
  $generate-resume-tex,
  blg:generate-pdf-with-pdflatex(
    $input-xml,
    $publish-path,
    $tex-out-path)
)
