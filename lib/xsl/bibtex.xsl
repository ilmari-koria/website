<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0">

  <xsl:output method="xml"
              encoding="UTF-8"
              indent="yes"/>

  <!-- use e.g. below for finding bibtex collection types
       ```
       let $name := for $x in //* return name($x)
       return distinct-values($name)
       ```
  -->

  <xsl:template match="/bibtex">
    <bibtex>
      <xsl:apply-templates />
    </bibtex>
  </xsl:template>

  <xsl:template match="incollection | article | book | misc">
    <entry>
      <key>
        <xsl:value-of select="@key"/>
      </key>
      <data>
        <!-- books and misc -->
        <xsl:if test="self::book or self::incollection or self::misc">
          <xsl:choose>
            <xsl:when test="not(@author)">
              <xsl:value-of select="@editor"/><xsl:text> (eds.)</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@author"/>
            </xsl:otherwise>
          </xsl:choose>
          (<xsl:value-of select="@year"/>).
          <em><xsl:value-of select="@title"/>.</em>
          <xsl:if test="self::incollection">
            <xsl:text> </xsl:text>
            <xsl:value-of select="@booktitle"/>.
          </xsl:if>
          <xsl:text> </xsl:text>
          <xsl:if test="@address">
            <xsl:value-of select="@address"/>,
          </xsl:if>
          <xsl:if test="@publisher">
            <xsl:value-of select="@publisher"/>.
          </xsl:if>
          <xsl:if test="@url">
            <code><xsl:value-of select="@url"/></code>
          </xsl:if>
        </xsl:if>
        <!-- articles -->
        <xsl:if test="self::article">
          <xsl:value-of select="@author"/>
          (<xsl:value-of select="@year"/>)
          '<xsl:value-of select="@title"/>',
          <em><xsl:value-of select="@journal"/></em>,
          <xsl:choose>
            <xsl:when test="@volume">Volume <xsl:value-of select="@volume"/>,</xsl:when>
            <xsl:otherwise></xsl:otherwise>
          </xsl:choose>
          <xsl:choose>
            <xsl:when test="@pages">pp. <xsl:value-of select="@pages"/>,</xsl:when>
            <xsl:otherwise></xsl:otherwise>
          </xsl:choose>
          <xsl:if test="@doi">
            <code><xsl:value-of select="@doi"/></code>
          </xsl:if>
          <xsl:if test="@url">
            <code><xsl:value-of select="@url"/></code>
          </xsl:if>
        </xsl:if>
      </data>
    </entry>
  </xsl:template>
</xsl:stylesheet>
