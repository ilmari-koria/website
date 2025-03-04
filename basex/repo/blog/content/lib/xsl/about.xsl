<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                version="2.0"
                exclude-result-prefixes="org">

  <xsl:output method="xml"
              indent="yes"
              omit-xml-declaration="yes" />

  <xsl:variable name="posts"
                select="document('../../tmp/xml/concat/posts-concat.xml')" />
  <xsl:variable name="reading-list"
                select="document('../../tmp/xml/reading-list/reading-list.xml')" />

  <xsl:include href="templates.xsl" />

  <xsl:template match="/">
    <xsl:call-template name="html" />
  </xsl:template>
  
  <xsl:template name="html">
    <html>
      <xsl:call-template name="meta">
        <xsl:with-param name="title" select="'About'" />
      </xsl:call-template>
      <xsl:call-template name="body" />
    </html>
  </xsl:template>

  <xsl:template name="body">
    <body>
      <xsl:call-template name="header" />
      <xsl:call-template name="about"/>
      <xsl:call-template name="footer" />
    </body>
  </xsl:template>

  <xsl:template name="about">
    <main>
      <article>
        <h2>About</h2>
        <xsl:call-template name="blurb"/>
        <p>Some of my interests include:
        <ul>
          <li>cycling</li>
          <li>field recording/phonography</li>
          <li>tinkering with free and open-source software</li>
          <li>language learning, and</li>
          <li>zazen.</li>
        </ul>
        </p>
        <p>On the work side of things, I am a content markup
        technologies professional, currently functioning as a
        (XML) Content Analyst at Bloomsbury Publishing in
        London.</p>
        <xsl:call-template name="contact"/>
        <xsl:call-template name="misc"/>
      </article>
    </main>
  </xsl:template>

  <xsl:template name="blurb">
    <table>
      <tr>
        <td>
          <figure>
            <img src="static/profile-pic.jpg" alt="Selfie with mid-30s caucasian man."/>
            <figcaption>
              Me / 2024.   
            </figcaption>
          </figure>
        </td>
        <td>
          <p>Hello! My name is Ilmari. This (work in progress)
          blog is simply for me to share assorted reflections on
          software, sound and zen.</p>
          <p>Currently this site serves as a sort scratch pad for learning
          about digital publishing processes.</p>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="contact">
    <details>
      <summary>
        <h3>Contact</h3>
      </summary>
      <ul>
        <li><a href="mailto:ilmarikoria@posteo.net">ilmarikoria@posteo.net</a></li>
        <li>Public Key: <code><a href="https://ilmarikoria.xyz/static/ilmari-koria-public-key.asc">D8DA 85D0 4C6A BD1F 8DA4 2895 3E3B 85AB 3A8D FFD4</a></code>.</li>
      </ul>
    </details>
  </xsl:template>

  <xsl:template name="misc">
    <details>
      <summary>
        <h3>Other stuff</h3>
      </summary>
      <ul>
        <li><a href="https://ilmarikoria.xyz/static/ilmari-koria-name.mp3">How to Pronounce My Name</a>.</li>
        <li>This site is generated using: 
        <ol>
          <li>
            <a href="https://www.gnu.org/software/emacs/">GNU Emacs</a>
            <ul>
              <li>
                <a href="https://orgmode.org/">org-mode</a> and 
                <a href="https://github.com/ndw/org-to-xml">org-to-xml</a>
              </li>
            </ul>
          </li>
          <li>
            <a href="https://www.saxonica.com/download/java.xml">SaxonJ-HE</a>
          </li>
        </ol>
        </li>
      </ul>
    </details>
  </xsl:template>

</xsl:stylesheet>
