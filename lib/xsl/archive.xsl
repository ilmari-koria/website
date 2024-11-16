<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                version="2.0"
                exclude-result-prefixes="org xs">

  <xsl:output method="xml"
              indent="yes"
              omit-xml-declaration="yes" />

  <xsl:variable name="posts"
                select="document('../../tmp/xml/concat/posts-concat.xml')" />

  <xsl:include href="header.xsl" />
  <xsl:include href="footer.xsl" />
  <xsl:include href="preamble.xsl" />

  <xsl:template match="/">
    <html>
      <xsl:call-template name="header">
        <xsl:with-param name="title" select="'Posts'" />
      </xsl:call-template>
      <body>
          <xsl:call-template name="preamble" />
          <div id="content">
            <h2>Posts</h2>
            <table>
              <xsl:for-each-group select="$posts/*:root/*:document/*:keyword[@key='TITLE']"
                                  group-by=".">
                <xsl:for-each select="current-group()">
                  <xsl:sort select="../*:keyword[@key='DATE']/@value"
                            order="descending"
                            data-type="text" />
                  <xsl:variable name="title" select="@value" />
                  <xsl:variable name="date"
                                select="../*:keyword[@key='DATE']/@value" />
                  <tr>
                    <td>📌</td>
                    <td>
                      <p><xsl:value-of select="format-date(xs:date($date), '[Y] [MNn,3-3] [D01]')" /></p>
                    </td>
                    <td>
                      <p>
                        <a href="https://ilmarikoria.xyz/{$date}-blog.html">
                        <xsl:value-of select="$title" /></a>
                      </p>
                    </td>
                  </tr>
                </xsl:for-each>
              </xsl:for-each-group>
            </table>
          </div>
        <xsl:call-template name="footer" />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
