<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                exclude-result-prefixes="org">

  <xsl:output method="xml"
              indent="yes"
              omit-xml-declaration="yes" />

  <xsl:variable name="posts"
                select="document('../../tmp/xml/concat/posts-concat.xml')" />

  <xsl:include href="header.xsl" />
  <xsl:include href="footer.xsl" />
  <xsl:include href="preamble.xsl" />

  <xsl:template match="/">
    <html>
      <xsl:call-template name="header">
        <xsl:with-param name="title" select="'About'" />
      </xsl:call-template>
      <body>
        <xsl:call-template name="preamble" />
        <div id="content">
          <div id="about">
            <h2>About</h2>
            <p>Hello! My name is Ilmari. This (work in progress)
            blog is simply for me to share assorted reflections on
            software, sound and zen.</p>
            <p>Some of my interests include:
            <ul>
              <li>cycling</li>
              <li>field recording/phonography</li>
              <li>tinkering with free and open-source software</li>
              <li>language learning, and</li>
              <li>Zazen.</li>
            </ul>
            </p>
            <p>On the work side of things, I am a content markup
            technologies professional, currently functioning as a
            (XML) Content Analyst at Bloomsbury Publishing in
            London.</p>
            <figure>
              <img src="static/profile-pic.jpg" alt="Selfie with mid-30s caucasian man."/>
              <figcaption>
                Me / 2024.   
              </figcaption>
            </figure>
            <p>Feel free to contact me via
            <ul>
              <li><a href="mailto:ilmarikoria@posteo.net">ilmarikoria@posteo.net</a></li>
              <li>Public Key: <a href="https://ilmarikoria.xyz/static/ilmari-koria-public-key.asc">D8DA 85D0 4C6A BD1F 8DA4 2895 3E3B 85AB 3A8D FFD4</a>.</li>
            </ul>
            </p>
            <h3>Other stuff</h3>
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
          </div>
        </div>
        <xsl:call-template name="footer" />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
