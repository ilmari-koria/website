<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                version="2.0"
                exclude-result-prefixes="org">

  <xsl:variable name="github"
                select="document('../../tmp/xml/github/github.atom')" />

  <xsl:template name="footer">
    <div id="postamble">
      <hr />
      <ul>
        <li>This site was last generated on <xsl:call-template name="generate-timestamp" />
            [Latest commit: 
              <a href="{$github/*:feed/*:entry[1]/*:link/@href}">
                <xsl:value-of select="substring(substring-after($github/*:feed/*:entry[1]/*:id, 'Commit/'), 1, 7)" />
              </a>]
        </li>
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
