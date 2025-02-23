import module namespace blg = "http://www.ilmarikoria.xyz";
declare variable $path-to-org-files external;
declare variable $publish-path external;
blg:publish-posts($publish-path)
