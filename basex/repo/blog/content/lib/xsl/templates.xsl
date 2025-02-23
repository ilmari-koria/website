<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                version="2.0"
                exclude-result-prefixes="org">

  <xsl:include href="style.xsl" />

  <xsl:param name="github-atom-path"/>
  <xsl:variable name="github"
                select="document($github-atom-path)" />
  <xsl:variable name="meta-description"
                select="org:document/org:keyword[@key = 'DESCRIPTION']/@value" />

  <xsl:template name="meta">
    <xsl:param name="title" />
    <head>
      <meta charset="UTF-8" />
      <meta name="description"
            content="{$meta-description}" />
      <meta name="author"
            content="Ilmari Koria" />
      <meta name="viewport"
            content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
      <link rel="alternate"
            type="application/rss+xml"
            href="atom.xml" title="atom feed" />
      <link rel="canonical"
            href="https://ilmarikoria.xyz" />
      <link rel="icon" type="image/png" href=
            "static/favicon.ico"/>
      <title>
        <xsl:value-of select="$title" />
      </title>
      <xsl:call-template name="style"/>
    </head>
  </xsl:template>

  <xsl:template name="header">
    <header>
      <h1>Ilmari's Webpage</h1>
    </header>
    <nav>
      <ul>
        <li><a href="https://ilmarikoria.xyz">Home</a></li>
        <li><a href="https://ilmarikoria.xyz/about.html">About</a></li>
        <li><a href="https://ilmarikoria.xyz/posts.html">Posts</a></li>
        <li><a href="https://ilmarikoria.xyz/reading-list.html">Reading List</a></li>
        <li><a href="https://ilmarikoria.xyz/atom.xml">RSS</a></li>
        <li><a href="https://ilmarikoria.xyz/ilmari-koria-resume.pdf">Résumé</a></li>
        <li><a href="https://freesound.org/people/ilmari_freesound/">Freesound</a></li>
        <li><a href="https://github.com/ilmari-koria/website">GitHub</a></li>
        <li><a href="https://www.meetup.com/london-cantonese-language-meetup/">Cantonese Language Meetup</a></li>
        <li><a href="https://bsky.app/profile/ilmarikoria.xyz">Bluesky</a></li>
      </ul>
    </nav>
  </xsl:template>

  <xsl:template name="footer">
    <footer>
      <hr />
      <ul>
        <li>This site was last generated on <xsl:call-template name="generate-timestamp" /> | Commit: 
        <a href="{$github/*:feed/*:entry[1]/*:link/@href}">
          <xsl:value-of select="substring(substring-after($github/*:feed/*:entry[1]/*:id, 'Commit/'), 1, 7)" />
          </a>.
        </li>
        <li>
          <a href="https://creativecommons.org/licenses/by-nc/4.0/">License</a>
        </li>
        <li>
          <a href="#top">Top</a>
        </li>
      </ul>
    </footer>
  </xsl:template>

  <xsl:template name="generate-timestamp">
    <xsl:value-of select="format-dateTime(current-dateTime(), '[Y0001]-[M01]-[D01] [H01]:[m01]:[s01]')"/>
  </xsl:template>

</xsl:stylesheet>
