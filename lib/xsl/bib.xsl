<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                exclude-result-prefixes="org"
                version="2.0">

  <xsl:output method="xml"
              encoding="UTF-8"
              indent="yes"/>

  <xsl:variable name="bibliography"
                select="document('../../tmp/xml/bibliography/bibliography.xml')" />

  <xsl:template name="bib">

    <xsl:if test="//org:link[contains(@raw-link, 'cite:')] != ''">
      <div id="references">
        <h2>References</h2>
        <table>
          <xsl:for-each-group select="//org:link[contains(@raw-link, 'cite:')]"
                              group-by="@raw-link">
            <xsl:variable name="key"
                          select="substring-after(@raw-link, 'cite:')" />
            <xsl:variable name="bib-entry"
                          select="$bibliography//*:a[@name = $key]/ancestor::*:tr" />
            <xsl:variable name="number"
                          select="$bib-entry//*:a[@name = $key]/text()" />
            <tr>
              <td>
                <p id="{$key}">[<a href="#{$key}"><xsl:value-of select="$number" /></a>]</p>
              </td>
              <td>
                <xsl:apply-templates select="$bib-entry//*:td[@class = 'bibtexitem']" />
              </td>
            </tr>
          </xsl:for-each-group>
        </table>
      </div>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>

