<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:c="http://ilmarikoria.xyz/ilmari-koria-cover-letter.pdf"
                exclude-result-prefixes="c"
                version="2.0">

  <xsl:strip-space elements="*"/>

  <xsl:output method="text"
              encoding="UTF-8"
              indent="no"
              omit-xml-declaration="yes"/>

  <xsl:template match="/">
    <xsl:text>    
      \documentclass[11pt]{letter}
      \usepackage[utf8]{inputenc}
      \usepackage[T1]{fontenc}
      \usepackage[a4paper]{geometry}
      \usepackage[british]{babel}
      \usepackage{lmodern}
    </xsl:text>
    <xsl:text>\signature{</xsl:text>
      <xsl:value-of select="letter/header/name"/>
    <xsl:text>}</xsl:text>
    <xsl:text>\author{</xsl:text>
      <xsl:value-of select="letter/header/name"/>
    <xsl:text>}</xsl:text>    
    <xsl:text>\address{</xsl:text>
      <xsl:value-of select="letter/header/address"/>
    <xsl:text>}</xsl:text>
    <xsl:text>\date{</xsl:text>
      <xsl:value-of select="format-date(current-date(), '[D01] [MNn] [Y0001]')"/>
    <xsl:text>}</xsl:text>
    <xsl:text>\title{</xsl:text>
      <xsl:value-of select="letter/header/name"/> Cover Letter --
      <xsl:value-of select="format-date(current-date(), '[D01] [MNn] [Y0001]')"/>
    <xsl:text>}</xsl:text>
    <xsl:text>
      \begin{document}
    </xsl:text>
    <xsl:text>\begin{letter}{Mr Lorem Ipsum\\Address}</xsl:text>
    <xsl:text>\opening{Dear Lorem Ipsum,}</xsl:text>
    <xsl:text> </xsl:text>
    <xsl:value-of select="letter/letter-body"/>
    <xsl:text> </xsl:text>
    <xsl:text>
      \closing{Kind regards,}
      \encl{Updated Resume}
      \end{letter}
      \end{document}
    </xsl:text>
   </xsl:template>
</xsl:stylesheet>
