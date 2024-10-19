<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                exclude-result-prefixes="org">

  <xsl:output method="xml"
              indent="yes"
              encoding="utf-8"/>

  <xsl:variable name="posts-concat"
                select="document('../../tmp/xml/concat/posts-concat.xml')" />

  <xsl:template match="/">

    <feed xmlns="http://www.w3.org/2005/Atom">
      <title>Ilmarikoria.xyz Feed</title>
      <link href="https://ilmarikoria.xyz/atom.xml" rel="self"/>
      <id>https://ilmarikoria.xyz/atom.xml</id>

      <!-- i.e., latest post -->
      <updated>
        <xsl:for-each select="$posts-concat//org:keyword[@key = 'DATE']/@value">
          <xsl:sort select="." order="descending" data-type="text"/>
          <xsl:if test="position() = 1">
            <xsl:value-of select="concat(., 'T00:00:00Z')"/>
          </xsl:if>
        </xsl:for-each>
      </updated>

      <author>
        <name>Ilmari Koria</name>
        <email>ilmarikoria@posteo.net</email>
      </author>
      
      <!-- posts -->
      <xsl:for-each select="$posts-concat/*/org:document">
        <xsl:variable name="date" select="org:keyword[@key='DATE']/@value" />
        <entry>
          <title>
            <xsl:value-of select="org:keyword[@key = 'TITLE']/@value"/>
          </title>
          <link href="https://ilmarikoria.xyz/{$date}-blog.html"/>
          <id>https://ilmarikoria.xyz/<xsl:value-of select="$date"/>-blog.html</id>
          <updated>
            <xsl:value-of select="concat($date, 'T00:00:00Z')"/>
          </updated>
          
          <summary>
            <xsl:variable name="text" select="(org:headline/org:section/org:paragraph)[1]" />
            <xsl:variable name="words" select="tokenize($text, '\s+')" />
            <xsl:for-each select="$words[position() &lt;= 50]">
              <xsl:value-of select="." />
              <xsl:if test="position() != last()"> <!-- Add a space between words -->
                <xsl:text> </xsl:text>
              </xsl:if>
            </xsl:for-each>
            <xsl:text> […]</xsl:text>
          </summary>
          
        </entry>
      </xsl:for-each>
    </feed>
  </xsl:template>
</xsl:stylesheet>
