<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                version="2.0"
                exclude-result-prefixes="org">

  <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

  <xsl:include href="templates.xsl" />

  <xsl:template match="*:headline[@level='1']">
    <html>
      <xsl:call-template name="meta">
        <xsl:with-param name="title" select="'Reading List'" />
      </xsl:call-template>
      <body>
        <xsl:call-template name="header" />
        <main>
          <xsl:call-template name="current-reading"/>
          <xsl:call-template name="done-reading"/>
        </main>
        <xsl:call-template name="footer" />
      </body>
    </html>
  </xsl:template>

  <xsl:template match="//*:headline[@todo-keyword='TODO']">
    <tr>
      <td>
        <img src="{*:section/*:property-drawer/*:node-property[@key='Img_url']/@value}" alt="Book Cover"/>
      </td>
      <td>
        <p>
          <i><xsl:value-of select="*:title"/></i>,
          <xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Author']/@value"/>
          (<xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Pub_year']/@value"/>),
          <xsl:if test="string(*:section/*:property-drawer/*:node-property[@key='Publisher']/@value) != ''">
            <xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Publisher']/@value"/>,
          </xsl:if>
          <xsl:if test="string(*:section/*:property-drawer/*:node-property[@key='Address']/@value) != ''">
            <xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Address']/@value"/>
          </xsl:if>
        </p>
        <xsl:if test="string(*:section/*:property-drawer/*:node-property[@key='ISBN']/@value) != ''">
          <p>
            <a href="https://search.worldcat.org/search?q={*:section/*:property-drawer/*:node-property[@key='ISBN']/@value}&amp;offset=1" target="_blank">Search title on WorldCat</a>
          </p>
        </xsl:if>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="*:headline[@todo-keyword='DONE']">
    <tr>
      <td><i><xsl:value-of select="*:title"/></i></td>
      <td><xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Author']/@value"/></td>
      <td><xsl:value-of select="*:section/*:property-drawer/*:node-property[@key='Pub_year']/@value"/></td>
      <td><a href="https://search.worldcat.org/search?q={*:section/*:property-drawer/*:node-property[@key='ISBN']/@value}&amp;offset=1" target="_blank">WorldCat</a></td>
    </tr>
  </xsl:template>

  <xsl:template name="current-reading">
    <article>
      <h2>I am currently reading:</h2>
      <table>
        <tbody>
          <xsl:apply-templates select="//*:headline[@todo-keyword='TODO']"/>
        </tbody>
      </table>
    </article>
  </xsl:template>

  <xsl:template name="done-reading">
    <section>
      <details>
        <summary>
          <h3>Books Read
          <xsl:value-of select="//*:headline[@level='2'][last()]/@raw-value"/>
          <xsl:text> - </xsl:text>
          <xsl:value-of select="//*:headline[@level='2'][1]/@raw-value"/>
          </h3>
        </summary>
        <article>
          <xsl:for-each select="//*:headline[@level='2']">
            <h3><xsl:value-of select="@raw-value"/></h3>
            <table>
              <tbody>
                <xsl:apply-templates select="*:headline[@todo-keyword='DONE']"/>
              </tbody>
            </table>
          </xsl:for-each>
        </article>
      </details>
    </section>
  </xsl:template>

</xsl:stylesheet>
