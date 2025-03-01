<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                version="2.0"
                exclude-result-prefixes="org">

  <xsl:variable name="bibliography"
                select="document($bibtex-xml)" />

  <xsl:template name="bib">
    <xsl:if test="//org:link[contains(@raw-link, 'cite:')] != ''">
      <section id="references">
        <h2>References</h2>
        <table>
          <xsl:for-each-group select="//org:link[contains(@raw-link, 'cite:')]"
                              group-by="@raw-link">
            <xsl:variable name="key"
                          select="substring-after(@raw-link, 'cite:')" />
            <xsl:variable name="bib-entry"
                          select="$bibliography//*:a[@name = $key]/ancestor::*:tr" />
            <xsl:variable name="number"
                          select="position()" />
            <tr>
              <td>[<a id="{$key}" href="#{$key}"><xsl:value-of select="$number" /></a>]</td>
              <td>
                <xsl:apply-templates select="$bib-entry//*:td[@class = 'bibtexitem']" />
              </td>
            </tr>
          </xsl:for-each-group>
        </table>
      </section>
    </xsl:if>
  </xsl:template>

  <xsl:template match="//org:link[contains(@raw-link, 'cite:')]">
    <xsl:variable name="key"
                  select="substring-after(@raw-link, 'cite:')" />
    <xsl:variable name="bib-entry"
                  select="$bibliography//*:a[@name = $key]/ancestor::*:tr" />
    <xsl:variable name="number"
                  select="position()" />
    [<a href="#{$key}"><xsl:value-of select="$number" /></a>]<xsl:text></xsl:text>
  </xsl:template>

  <xsl:template match="$bibliography//*:a[@href]">
    <xsl:variable name="link"
                  select="@href" />
    <a href="{$link}">
      <xsl:value-of select="normalize-space(.)" />
    </a>
  </xsl:template>

</xsl:stylesheet>
