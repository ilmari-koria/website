<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                version="2.0"
                exclude-result-prefixes="org">

  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="directory-path" select="'../../tmp/xml/posts'"/>
  
  <xsl:template match="/">
    <root>
      <xsl:for-each select="collection(concat($directory-path, '?select=*.xml;recurse=no'))">
        <xsl:copy-of select="/*"/>
      </xsl:for-each>
    </root>
  </xsl:template>

</xsl:stylesheet>
