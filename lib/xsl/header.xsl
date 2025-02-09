<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                version="2.0"
                exclude-result-prefixes="org">

  <xsl:template name="header">
    <header>
      <div class="website-title">
        <img id="logo" src="static/logo.png" alt="Statue of smiling Buddhist monk."/>
        <h1>Ilmari's Webpage</h1>
      </div>
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
    </header>
  </xsl:template>

</xsl:stylesheet>
