<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                exclude-result-prefixes="org"
                version="2.0">

  <xsl:output method="xml"
              encoding="UTF-8"
              indent="yes"/>

  <xsl:variable name="footnote-number"
                select="org:footnote-reference/@label" />

  <xsl:template name="footnotes">
    <xsl:if test="//org:footnote-definition != ''">
      <div class="footnotes">
        <h2>Footnotes</h2>
        <table>
          <xsl:for-each-group select="//org:footnote-definition"
                              group-by="org:paragraph">
            <xsl:for-each select="current-group()">
              <xsl:variable name="footnote-label"
                            select="@label" />
              <tr>
                <td id="footnote{$footnote-label}">
                  <xsl:text>[</xsl:text>
                  <a href="#footnote{$footnote-label}">
                    <xsl:value-of select="$footnote-label" />
                  </a>
                  <xsl:text>]</xsl:text>
                </td>
                <td>
                  <xsl:apply-templates />
                </td>
              </tr>
            </xsl:for-each>
          </xsl:for-each-group>
        </table>
      </div>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>

