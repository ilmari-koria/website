<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                version="2.0"
                exclude-result-prefixes="org">

  <xsl:output method="xml"
              indent="yes"
              omit-xml-declaration="yes" />

  <xsl:variable name="meta-description"
                select="org:document/org:keyword[@key = 'DESCRIPTION']/@value" />

  <xsl:template name="meta">
    <xsl:param name="title" />
    <head>
      <meta charset="UTF-8" />
      <meta name="description"
            content="{$meta-description}" />
      <meta name="author"
            content="Ilmari Koria" />
      <meta name="viewport"
            content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
      <link rel="alternate"
            type="application/rss+xml"
            href="atom.xml" title="atom feed" />
      <link rel="canonical"
            href="https://ilmarikoria.xyz" />
      <link rel="stylesheet"
            href="style.css"
            type="text/css" />
      <link rel="icon" type="image/png" href=
            "static/favicon.ico"/>
      <title>
        <xsl:value-of select="$title" />
      </title>
    </head>
  </xsl:template>
</xsl:stylesheet>
