<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                version="2.0"
                exclude-result-prefixes="org">
  
  <!-- convert this into a param -->

  <xsl:variable name="bibliography-footnotes"
                select="document($bibtex-xml)" />
  <xsl:variable name="footnote-number"
                select="org:footnote-reference/@label" />

  <xsl:template name="footnotes">
    <xsl:if test="//org:footnote-definition != ''">
      <section class="footnotes">
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
      </section>
    </xsl:if>
  </xsl:template>

  <!-- TODO avoid priority hacks   -->
  <xsl:template match="org:footnote-definition//org:link" priority="2">
    <xsl:choose>
      <xsl:when test="contains(@raw-link, 'cite:')">
        <xsl:variable name="key" select="substring-after(@raw-link, 'cite:')" />
        <xsl:variable name="bib-entry" select="$bibliography-footnotes//*:a[@name = $key]/ancestor::*:tr" />
        <xsl:variable name="number" select="$bib-entry//*:a[@name = $key]/text()" />
        <span class="footnote-link">[<a href="#{$key}">
        <xsl:value-of select="$number" />
        </a>]</span>
      </xsl:when>
      <xsl:otherwise>
        <a href="{@raw-link}">
          <xsl:apply-templates/>
        </a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


</xsl:stylesheet>

