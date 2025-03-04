<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                version="2.0"
                exclude-result-prefixes="org">

  <xsl:output method="xml"
              indent="yes"
              omit-xml-declaration="yes" />

  <xsl:include href="templates.xsl" />

  <xsl:template match="/">
    <html>
      <xsl:call-template name="meta">
        <xsl:with-param name="title" select="'Index'" />
      </xsl:call-template>
      <body>
        <xsl:call-template name="header" />
        <main>
          <article>
            <h2>Recent Posts</h2>
            <table>
              <xsl:for-each-group select="/*:root/*:document/*:keyword[@key='TITLE']" group-by=".">
                <xsl:for-each select="current-group()">
                  <xsl:sort select="../*:keyword[@key='DATE']/@value" order="descending" data-type="text" />
                  <xsl:if test="position() &lt;= 3">
                    <xsl:variable name="title" select="@value" />
                    <xsl:variable name="date" select="../*:keyword[@key='DATE']/@value" />
                    <tr>
                      <td>
                        <xsl:value-of select="format-date(xs:date($date), '[Y] [MNn,3-3] [D01]')" />
                      </td>
                      <td>
                        <a href="https://ilmarikoria.xyz/{$date}-blog.html">
                        <xsl:value-of select="$title" /></a>
                      </td>
                    </tr>
                  </xsl:if>
                </xsl:for-each>
              </xsl:for-each-group>
            </table>
          </article>
        </main>
        <xsl:call-template name="footer" />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
