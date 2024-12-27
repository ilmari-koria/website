xquery version "3.1";
import module namespace ik-fn = "http://www.ilmarikoria.xyz" at "lib-publish.xqm";

(:
 : ik-fn:el-generate-xml-from-org(),
 : ik-fn:concat-xml-files(),
 : ik-fn:xsl-transform-misc(),
 : ik-fn:xsl-transform-posts()
 :)

ik-fn:get-github-atom(),
ik-fn:xsl-generate-tex(),
ik-fn:tex-generate-pdf(),
ik-fn:tex-clean-tmp-files()