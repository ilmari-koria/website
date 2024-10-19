<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                exclude-result-prefixes="org"
                version="3.0">

  <xsl:template name="footer">
    <div id="postamble">
      <hr />
      <ul>
        <li>This site was last generated on <xsl:call-template name="generate-timestamp" />.</li>
        <li>
          <a href="https://creativecommons.org/licenses/by-nc/4.0/">License</a>
        </li>
        <li>
          <a href="#top">Top</a>
        </li>
      </ul>
    </div>
  </xsl:template>

  <xsl:template name="generate-timestamp">
    <xsl:value-of select="format-dateTime(current-dateTime(), '[Y0001]-[M01]-[D01] [H01]:[m01]:[s01]')"/>
  </xsl:template>

</xsl:stylesheet>
