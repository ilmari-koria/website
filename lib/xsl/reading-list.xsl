<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                version="2.0"
                exclude-result-prefixes="org">

  <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

  <xsl:include href="header.xsl" />
  <xsl:include href="footer.xsl" />
  <xsl:include href="preamble.xsl" />

  <xsl:template match="/*:document/*:headline[@level='1']">
    <html>
      <xsl:call-template name="header">
        <xsl:with-param name="title" select="'Reading List'" />
      </xsl:call-template>
      <body>
        <xsl:call-template name="preamble" />
        <div id="content">
          <div id="list-todo">
            <h2 id="reading-heading-current">I am currently reading:</h2>
            <table class="reading-list">
              <tbody>
                <xsl:apply-templates select="*:headline[@todo-keyword='TODO']"/>
              </tbody>
            </table>
          </div>
          <div id="list-done">
            <h3 id="reading-heading-done">Books I read in <xsl:value-of select="*:headline[@todo-keyword='DONE']/parent::*:headline[@level='1']/@raw-value"/>:</h3>
            <table class="reading-list-done">
              <tbody>
               <xsl:apply-templates select="*:headline[@todo-keyword='DONE']"/>
              </tbody>
            </table>
          </div>
        </div>
        <xsl:call-template name="footer" />
      </body>
    </html>
  </xsl:template>
  <xsl:template match="*:headline[@todo-keyword='TODO']">
    <tr>
      <td class="image-column">
        <img src="{*:section/*:property-drawer/*:node-property[@key='Img_url']/@value}" alt="Book Cover"/>
      </td>
      <td>
        <p class="book-title"><xsl:value-of select="*:title"/></p>
        <p>
          <xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Author']/@value"/><xsl:text> </xsl:text>
          (<xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Pub_year']/@value"/>)
        </p>
        <br/>
        <p>
          <xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Publisher']/@value"/><xsl:text>, </xsl:text>
          <xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Address']/@value"/>
        </p>
        <p><a href="https://search.worldcat.org/search?q={*:section/*:property-drawer/*:node-property[@key='ISBN']/@value}&amp;offset=1" target="_blank">Search Title on WorldCat</a></p>
      </td>
    </tr>
  </xsl:template>
  <xsl:template match="*:headline[@todo-keyword='DONE']">
    <tr>
      <td><em><xsl:value-of select="*:title"/></em></td>
      <td><xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Author']/@value"/></td>
      <td>(<xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Pub_year']/@value"/>)</td>
      <td>[<a href="https://search.worldcat.org/search?q={*:section/*:property-drawer/*:node-property[@key='ISBN']/@value}&amp;offset=1" target="_blank">WorldCat</a>]</td>
    </tr>
  </xsl:template>

</xsl:stylesheet>
