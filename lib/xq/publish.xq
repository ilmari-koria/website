xquery version "3.1";
import module namespace ik-fn = "http://www.ilmarikoria.xyz" at "lib-publish.xqm";

(:~
 : blog publish function calls
 : @author   ilmarikoria@posteo.net
 : @version  0.1
 :)

(: generate pages :)
ik-fn:el-generate-xml-from-org(),
ik-fn:concat-xml-files(),
ik-fn:xsl-transform-misc(),
ik-fn:xsl-transform-posts(),

(: retrieve github atom feed :)
ik-fn:get-github-atom(),

(: generate resume :)
ik-fn:xsl-generate-tex(),
ik-fn:tex-generate-pdf(),
ik-fn:tex-clean-tmp-files()