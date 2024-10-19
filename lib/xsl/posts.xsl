<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                exclude-result-prefixes="org">

  <xsl:output method="xml"
              indent="yes"
              encoding="UTF-8"
              omit-xml-declaration="yes" />

  <xsl:include href="header.xsl" />
  <xsl:include href="footer.xsl" />
  <xsl:include href="preamble.xsl" />
  <xsl:include href="footnotes.xsl" />
  <xsl:include href="bib.xsl" />

  <xsl:template match="/">
    <html>
      <xsl:call-template name="header">
        <xsl:with-param name="title" select="org:document/org:keyword[@key = 'TITLE']/@value" />
      </xsl:call-template>
      <body>
        <xsl:call-template name="preamble" />
        <div id="content">
          <xsl:apply-templates select="org:keyword[@key = 'TITLE']"/>
          <xsl:apply-templates select="org:keyword[@key = 'DATE']"/>
          <xsl:apply-templates />
          <xsl:call-template name="footnotes" />
          <xsl:call-template name="bib" />
        </div>
        <xsl:call-template name="footer" />
      </body>
    </html>
  </xsl:template>

  <xsl:template match="org:headline/org:title">
    <xsl:if test="not(ancestor::org:headline[org:tags='ignore'])">
      <xsl:element name="h{../@level + 1}">
        <xsl:apply-templates />
      </xsl:element>
    </xsl:if>
  </xsl:template>

  <xsl:template match="org:document/org:headline/org:tags[. = 'ignore']"/>

  <xsl:template match="org:keyword[@key = 'TITLE']">
      <h2 class="post-title"><xsl:value-of select="@value" /></h2>
  </xsl:template>

  <xsl:template match="org:keyword[@key = 'DATE']">
      <p class="post-date">Posted: <xsl:value-of select="@value" /></p>
  </xsl:template>

  <xsl:template match="org:paragraph">
    <p>
      <xsl:apply-templates />
    </p>
  </xsl:template>

  <xsl:template match="org:plain-list[@type='ordered']">
    <ol>
      <xsl:apply-templates select="org:item/org:paragraph" />
    </ol>
  </xsl:template>

  <xsl:template match="org:plain-list[@type='unordered']">
    <ul>
      <xsl:apply-templates select="org:item/org:paragraph" />
    </ul>
  </xsl:template>

  <xsl:template match="org:item/org:paragraph">
    <li>
      <xsl:apply-templates />
    </li>
  </xsl:template>

  <xsl:template match="org:bold">
    <b>
      <xsl:apply-templates />
    </b>
  </xsl:template>

  <xsl:template match="org:italic">
    <i>
      <xsl:apply-templates />
    </i>
  </xsl:template>

  <xsl:template match="org:code">
    <pre>
      <xsl:apply-templates />
    </pre>
  </xsl:template>

  <xsl:template match="org:em">
    <em>
      <xsl:apply-templates/>
    </em>
  </xsl:template>

  <xsl:template match="org:footnote-reference">
    <sup>
      <a href="#fn-{@label}">
        <xsl:value-of select="@label" />
      </a>
    </sup>
  </xsl:template>

  <xsl:template match="org:quote-block">
    <blockquote>
      <xsl:apply-templates />
    </blockquote>
  </xsl:template>
  
  <xsl:template match="org:link[@type='http' or @type='https']">
    <a href="{@raw-link}">
      <xsl:choose>
        <xsl:when test="@format='bracket'">
          <xsl:apply-templates />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@raw-link" />
        </xsl:otherwise>
      </xsl:choose>
    </a>
  </xsl:template>

  <!-- TODO this is repeating values set in bib.xsl -->
  <xsl:template match="org:link[contains(@raw-link, 'cite:')]">
    <xsl:variable name="key"
                  select="substring-after(@raw-link, 'cite:')" />
    <xsl:variable name="bib-entry"
                  select="$bibliography//*:a[@name = $key]/ancestor::*:tr" />
    <xsl:variable name="number"
                  select="$bib-entry//*:a[@name = $key]/text()" />
    [<a href="#{$key}"><xsl:value-of select="$number" /></a>]
  </xsl:template>

  <xsl:template match="org:link[@path and matches(@path, '\.(gif|jpg|jpeg|png)$')]">
    <figure>
      <img src="{@path}" alt="{@raw-link}" />
          <figcaption>
            <xsl:value-of select="preceding-sibling::org:caption[1]" />
          </figcaption>
    </figure>
  </xsl:template>
  
  <xsl:template match="org:paragraph/org:caption" />

  <xsl:template match="org:export-block[@type='HTML']">
    <xsl:variable name="html-code-block"
                  select="normalize-space(@value)" />
    <xsl:value-of select="$html-code-block"
                  disable-output-escaping="yes" />
  </xsl:template>

  <xsl:template match="org:link[@type='mailto']">
    <xsl:variable name="mailto-link"
                  select="@path" />
    <a href="mailto:{normalize-space($mailto-link)}">
      <xsl:value-of select="." />
    </a>
  </xsl:template>

  <!-- TODO avoid // if possible -->
  <xsl:template match="//org:footnote-definition"/>

 <xsl:template match="org:verse-block">
    <blockquote class="verse-block">
      <xsl:analyze-string select="."
                          regex="([^\r\n]+)">
        <xsl:matching-substring>
          <xsl:value-of select="."/>
          <br/>
        </xsl:matching-substring>
      </xsl:analyze-string>
    </blockquote>
  </xsl:template>

</xsl:stylesheet>

