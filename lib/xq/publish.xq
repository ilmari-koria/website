xquery version "3.1";
import module namespace ik-fn = "http://www.ilmarikoria.xyz" at "lib-publish.xqm";
import module namespace ik-bib = "http://www.ilmarikoria.xyz/bibtex" at "bibtex-parser.xqm";
declare option output:indent "yes";

(:~
 : blog publish function calls
 : @author   ilmarikoria@posteo.net
 : @version  0.1
 :)

(: TODO check docs for best practices re- message vs. trace :)


try {
  fn:message("ℹ️  Retrieving commit details"),
  ik-fn:get-github-atom(),
  fn:message("ℹ️  Generating XML from org files"),
  ik-fn:el-generate-xml-from-org(),
  fn:message("ℹ️  Constructing master XML doc"),
  ik-fn:concat-xml-files(),
  fn:message("ℹ️  Transforming misc files"),
  ik-fn:xsl-transform-misc(),
  fn:message("ℹ️  Transforming posts"),
  ik-fn:xsl-transform-posts(),
  fn:message("ℹ️  Generating CSS"),
  ik-fn:xsl-generate-css(),
  fn:message("ℹ️  Generating resume TeX markup"),
  ik-fn:xsl-generate-tex(),
  fn:message("ℹ️  Generating resume pdf"),
  ik-fn:tex-generate-pdf(),
  fn:message("ℹ️  Cleaning up tmp files"),
  ik-fn:tex-clean-tmp-files(),
  fn:message("✅ Site files updated")
} catch * {
    fn:message('❌ Error [' || $err:code || ']: ' || $err:description)
    }




