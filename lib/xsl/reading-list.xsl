<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                version="2.0"
                exclude-result-prefixes="org">

  <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

  <xsl:include href="header.xsl" />
  <xsl:include href="footer.xsl" />
  <xsl:include href="preamble.xsl" />

  <xsl:key name="year-key" match="*:document/*:headline" use="*:section/*:property-drawer/*:node-property[@key='Date']/@value" />
  
  <xsl:template match="/*:document">
    <html>
      <xsl:call-template name="header">
        <xsl:with-param name="title" select="'Reading List'" />
      </xsl:call-template>
      <body>
        <xsl:apply-templates select="*:headline[@todo-keyword='TODO']"/>
        <xsl:apply-templates select="*:headline[@todo-keyword='DONE']"/>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="*:headline[@todo-keyword='TODO']">
    <h2>I am currently reading:</h2>
    <table class="reading-list">
      <tbody>
        <tr>
          <td class="image-column">
            <img src="{*:section/*:property-drawer/*:node-property[@key='Img_url']/@value}" alt="Book Cover"/>
          </td>
          <td>
            <p class="book-title"><xsl:value-of select="*:title"/></p>
            <p>
              <xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Author']/@value"/><xsl:text> </xsl:text>
              (<xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Pub_year']/@value"/>)<xsl:text>, </xsl:text>
              <xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Publisher']/@value"/><xsl:text>, </xsl:text>
              <xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Address']/@value"/><xsl:text>, </xsl:text>
            </p>
            <p><a href="https://search.worldcat.org/search?q={*:section/*:property-drawer/*:node-property[@key='ISBN']/@value}&amp;offset=1" target="_blank">Search Title on WorldCat</a></p>
          </td>
        </tr>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="*:headline[@todo-keyword='DONE']">
    <xsl:for-each-group select="*:section/*:property-drawer/*:node-property[@key='Date']" group-by="@value">
      <xsl:variable name="year" select="@value" />
      <h2>Books Read in <xsl:value-of select="$year"/></h2>
      <table class="reading-list">
        <tbody>
          <xsl:for-each select="current-group()">
            <tr>
              <td class="image-column">
                <img src="{../*:node-property[@key='Img_url']/@value}" alt="Book Cover"/>
              </td>
              <td>
                <p class="book-title"><xsl:value-of select="../../../*:title"/></p>
                <p>
                  <xsl:value-of select="../*:node-property[@key='Author']/@value"/><xsl:text> </xsl:text>
                  (<xsl:value-of select="../*:node-property[@key='Pub_year']/@value"/>)<xsl:text>, </xsl:text>
                  <xsl:value-of select="../*:node-property[@key='Publisher']/@value"/><xsl:text>, </xsl:text>
                  <xsl:value-of select="../*:node-property[@key='Address']/@value"/><xsl:text> </xsl:text>
                </p>
                <p><a href="https://search.worldcat.org/search?q={*:section/*:property-drawer/*:node-property[@key='ISBN']/@value}&amp;offset=1" target="_blank">Search Title on WorldCat</a></p>
              </td>
            </tr>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:for-each-group>
  </xsl:template>
</xsl:stylesheet>
