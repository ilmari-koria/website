<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:r="http://ilmarikoria.xyz/ilmari-koria-resume.pdf"
                exclude-result-prefixes="r"
                version="2.0">

  <xsl:output method="text"
              encoding="UTF-8"
              indent="no"
              omit-xml-declaration="yes"/>

  <xsl:include href="resume-header-expanded.xsl" />
  <xsl:param name="resume-header"/>

  <xsl:template match="/">
      \input{<xsl:value-of select="$resume-header"/>}
      \begin{document}
      \pagestyle{fancy}
      \section*{<xsl:value-of select="resume/header/name"/>}

      \begin{center}
      Résumé: Generated <xsl:value-of select="format-date(current-date(), '[D01] [MNn] [Y0001]')"/>
      ---
      \href{mailto: <xsl:value-of select="resume/header/email/@mailto"/>}
      {\texttt{<xsl:value-of select="resume/header/email"/>}}
      --- <xsl:value-of select="resume/header/address"/>
      \end{center}

      <xsl:call-template name="resume-header-expanded"/>

      \subsection*{About}
      <xsl:value-of select="resume/about" />

      \subsection*{Experience}
      <xsl:for-each select="resume/experience/experience-entry">
      \subsubsection*{
      \textbf{<xsl:value-of select="company"/>}, 
      <xsl:value-of select="department"/>
      \hfill <xsl:value-of select="address"/>}
      \begin{itemize}
      \item\emph{<xsl:value-of select="role"/>}\hfill

        <xsl:call-template name="format-date-range">
            <xsl:with-param name="start-date" select="time-start"/>
            <xsl:with-param name="end-date" select="time-end"/>
        </xsl:call-template>

      \begin{itemize}
        <xsl:for-each select="role-achievements/achievement">
       	\item <xsl:value-of select="."/>
       	<xsl:text> </xsl:text>
       	</xsl:for-each>
        \end{itemize}
        \end{itemize}
       </xsl:for-each>

      \subsection*{Professional Development}
      \bulletlist
      \begin{itemize}
        <xsl:for-each select="resume/training/training-entry">
        \item <xsl:value-of select="role"/>:
        \textit{<xsl:value-of select="name"/>},
          <xsl:value-of select="institute"/>,
          <xsl:value-of select="training-hours"/>
            <xsl:choose>
              <xsl:when test="number(training-hours) != number(training-hours)">
                <xsl:text> </xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text> hrs. </xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          \hfill
          <xsl:value-of select="date"/>
      </xsl:for-each>
      \end{itemize}

      \subsection*{Education}
    <xsl:for-each select="resume/education/education-entry">
      \textbf{<xsl:value-of select="institute"/>}, 
      \textit{<xsl:value-of select="result"/>}, 
      <xsl:value-of select="address"/>
      <xsl:if test="position() != last()">
        <xsl:text> --- </xsl:text>
      </xsl:if>
    </xsl:for-each>.

     \subsection*{Skills}
     \textbf{Tools:}
    <xsl:for-each select="resume/skill-list/skill-entry">
      <xsl:sort select="lower-case(translate(., '\', ''))" data-type="text" order="ascending"/>
      <xsl:value-of select="."/>
      <xsl:if test="position() != last()">
       ,
      </xsl:if>
    </xsl:for-each>
    --- 
    \textbf{Languages:}
    <xsl:for-each select="resume/language-list/language-entry">
      <xsl:value-of select="language"/>
      <xsl:if test="position() != last()">
       , 
      </xsl:if>
    </xsl:for-each>.
  <xsl:text>\end{document}</xsl:text>
</xsl:template>

<xsl:template name="format-date-range">
  <!-- format date differences in experience -->
  <xsl:param name="start-date"/>
  <xsl:param name="end-date"/>
  <xsl:variable name="final-end-date" select="if ($end-date = 'Present') then 'Present' else xs:date(concat(substring($end-date, 4, 4), '-', substring($end-date, 1, 2), '-01'))"/>
  <xsl:variable name="formatted-start-date" select="format-date(xs:date(concat(substring($start-date, 4, 4), '-', substring($start-date, 1, 2), '-01')), '[MNn,3-3] [Y]')"/>
  <xsl:variable name="formatted-end-date" select="if ($end-date = 'Present') then 'Present' else format-date($final-end-date, '[MNn,3-3] [Y]')"/>
  <xsl:variable name="current-date" select="current-date()"/>
  <xsl:variable name="start-date-object" select="xs:date(concat(substring($start-date, 4, 4), '-', substring($start-date, 1, 2), '-01'))"/>
  <xsl:variable name="years-diff" select="if ($end-date = 'Present') then year-from-date($current-date) - year-from-date($start-date-object) else year-from-date($final-end-date) - year-from-date($start-date-object)"/>
  <xsl:variable name="months-diff" select="if ($end-date = 'Present') then month-from-date($current-date) - month-from-date($start-date-object) else month-from-date($final-end-date) - month-from-date($start-date-object)"/>
  <xsl:variable name="adjusted-years" select="if ($months-diff &lt; 0) then $years-diff - 1 else $years-diff"/>
  <xsl:variable name="adjusted-months" select="if ($months-diff &lt; 0) then $months-diff + 12 else $months-diff"/>
  <xsl:value-of select="$formatted-start-date"/>
  <xsl:text> -- </xsl:text>
  <xsl:value-of select="$formatted-end-date"/>
  <xsl:text> </xsl:text>
  <xsl:text>(\textbf{</xsl:text>
  <xsl:if test="$adjusted-years != 0">
    <xsl:value-of select="$adjusted-years"/><xsl:text>y </xsl:text>
  </xsl:if>
  <xsl:value-of select="$adjusted-months"/>
  <xsl:text>m})</xsl:text>
</xsl:template>
</xsl:stylesheet>
