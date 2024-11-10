<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="https://nwalsh.com/ns/org-to-xml"
                version="2.0">
  <xsl:output method="html" indent="yes" />
  <xsl:template match="/*:document">
    <html>
      <head>
        <title>ilmarikoria.xyz Reading List</title>
      </head>
      <body>
        <xsl:apply-templates select="*:headline[@todo-keyword='TODO']"/>
        <xsl:apply-templates select="*:headline[@todo-keyword='DONE']"/>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="*:headline[@todo-keyword = 'TODO']">
    <h2>TODO Books</h2>
    <table class="reading-list">
      <tbody>
        <tr>
          <td class="image-column">
            <img src="{*:section/*:property-drawer/*:node-property[@key='Img_url']/@value}" alt="Book Cover"/>
          </td>
          <td>
            <p class="book-title"><xsl:value-of select="*:title"/></p>
            <p>
              <xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Author']/@value"/><xsl:text>, </xsl:text>
              <xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Pub_year']/@value"/><xsl:text>, </xsl:text>
              <xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='ISBN']/@value"/><xsl:text>, </xsl:text>
              <xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Publisher']/@value"/><xsl:text>, </xsl:text>
              <xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Address']/@value"/><xsl:text>, </xsl:text>
              <xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Date']/@value"/>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="*:headline[@todo-keyword = 'DONE']">
    <h2>Completed Books</h2>
    <table class="reading-list">
      <tbody>
        <tr>
          <td class="image-column">
            <img src="{*:section/*:property-drawer/*:node-property[@key='Img_url']/@value}" alt="Book Cover"/>
          </td>
          <td>
            <p class="book-title"><xsl:value-of select="*:title"/></p>
            <p>
              <xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Author']/@value"/><xsl:text>, </xsl:text>
              <xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Pub_year']/@value"/><xsl:text>, </xsl:text>
              <xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='ISBN']/@value"/><xsl:text>, </xsl:text>
              <xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Publisher']/@value"/><xsl:text>, </xsl:text>
              <xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Address']/@value"/><xsl:text>, </xsl:text>
              <xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Date']/@value"/>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
  </xsl:template>
</xsl:stylesheet>
