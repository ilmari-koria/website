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

  <!-- this stylesheet should not be auto-indented. -->

  <xsl:template match="/">
    
    \documentclass[a4paper]{article}
    \title{<xsl:value-of select="resume/header/name"/> Resume}
    \author{<xsl:value-of select="resume/header/name"/>}
    \date{}

    \usepackage[british]{babel}

    \usepackage{fancyhdr}
    \pagestyle{fancy}
    \fancyhf{}

    \usepackage[cm]{fullpage}

    \usepackage{xcolor}
    \definecolor{navyblue}{RGB}{0,0,128}

    \usepackage{href-ul}
    \usepackage{hyperref}
    \hypersetup{
    colorlinks,
    breaklinks,
    allcolors={navyblue},
    pdfauthor={<xsl:value-of select="resume/header/name"/>},                             
    pdftitle={<xsl:value-of select="resume/header/name"/> Resume},
    pdfkeywords={resume},                                       
    pdfsubject={resume},                                        
    pdfcreator={},             
    pdflang={English}                                    
    }

    \renewcommand{\headrulewidth}{0pt}

    \usepackage{lastpage}

    \usepackage{tabto}
    \newcommand\mytab{\tab \hspace{-22em}}

    \setlength{\parindent}{0pt}

    \input{glyphtounicode}
    \pdfgentounicode=1

    \usepackage[T1]{fontenc}
    \usepackage{lmodern}

    \usepackage{microtype}

    \usepackage{titlesec}
    \titleformat{\section}{\huge\scshape\centering}{0em}{0em}{}
    \titleformat{\subsection}{\large\scshape\centering}{0em}{0em}{}[\titlerule]
    \titleformat{\subsubsection}{\normalsize}{0em}{0em}{}

    \titlespacing*{\section}{0em}{0em}{0em}
    \titlespacing*{\subsection}{0em}{4.15em}{1em}
    \titlespacing*{\subsubsection}{0em}{1.5em}{0em}

    \usepackage{enumitem}
    \renewcommand\labelitemi{}
    \renewcommand\labelitemii{\hfill$\vcenter{\hbox{\footnotesize{$\bullet$}}}$\hfill}
    \setlist[itemize,1]{before=\normalsize,itemsep=0em,topsep=0em,leftmargin=*,labelindent=0em,labelsep=0em}
    \setlist[itemize,2]{before=\normalsize,itemsep=0em,topsep=0em,leftmargin=*,labelindent=0em,labelsep=0.5em}

    \newcommand{\bulletlist}{\renewcommand\labelitemi{\hfill$\vcenter{\hbox{\footnotesize{$\bullet$}}}$\hfill}\setlist[itemize,1]{before=\normalsize,itemsep=0em,topsep=0em,leftmargin=*,labelindent=0em,labelsep=0.5em}}
    \newcommand{\nobulletlist}{\renewcommand\labelitemi{}\setlist[itemize,1]{before=\normalsize,itemsep=0em,topsep=0em,leftmargin=*,labelindent=0em,labelsep=0em}}

    \usepackage{setspace}

    \usepackage{soul}
    \setul{1pt}{.4pt}

    \usepackage{CJKutf8}
    \newcommand{\chquo}[1]{\begin{CJK*}{UTF8}{bkai}#1\end{CJK*}}
    \newcommand{\chtex}[1]{\begin{CJK*}{UTF8}{bsmi}#1\end{CJK*}}

    \usepackage{ruby}
    \renewcommand{\rubysize}{0.4}
    \renewcommand{\rubysep}{0.25ex}

    \usepackage{tabularx}

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

    \begin{footnotesize}
      \centering
        \begin{tabular*}{\textwidth}{l@{\extracolsep{\fill}}l}

          Website: \href{<xsl:value-of select="resume/header/website/@href"/>}
          {\texttt{<xsl:value-of select="resume/header/website"/>}} &amp;
          
          \chtex{華文姓名：}
          \ruby{\chtex{<xsl:value-of select="/resume/header/name-zh/family"/>}}
                      {<xsl:value-of select="/resume/header/name-zh-pinyin/family"/>}
          \ruby{\chtex{<xsl:value-of select="/resume/header/name-zh/given-first"/>}}
                      {<xsl:value-of select="/resume/header/name-zh-pinyin/given-first"/>}
          \ruby{\chtex{<xsl:value-of select="/resume/header/name-zh/given-second"/>}}
                      {<xsl:value-of select="/resume/header/name-zh-pinyin/given-second"/>} \\

          GitHub: \href{<xsl:value-of select="resume/header/github/@href"/>}
          {\texttt{<xsl:value-of select="resume/header/github"/>}} &amp;

          References: <xsl:value-of select="resume/header/references"/> \\

          Public key: \href{<xsl:value-of select="resume/header/public-key/@href"/>}
          {\texttt{<xsl:value-of select="resume/header/public-key"/>}} &amp;

          \href{<xsl:value-of select="resume/header/name-audio/@href"/>}
          {\texttt{<xsl:value-of select="resume/header/name-audio"/>}} \\ 

        \end{tabular*}
    \end{footnotesize}

    \subsection*{About}<xsl:text> </xsl:text>
    <xsl:value-of select="resume/about" />

    \subsection*{Experience}<xsl:text> </xsl:text>
    <xsl:for-each select="resume/experience/experience-entry">
      \subsubsection*{\textbf{<xsl:value-of select="company"/>}, <xsl:value-of select="department"/>
        \hfill <xsl:value-of select="address"/>}
      \begin{itemize}
        \item\emph{<xsl:value-of select="role"/>}
        \hfill <xsl:call-template name="format-date-range">
                 <xsl:with-param name="start-date" select="time-start"/>
                 <xsl:with-param name="end-date" select="time-end"/>
               </xsl:call-template>
        \begin{itemize}<xsl:text> </xsl:text>
          <xsl:for-each select="role-achievements/achievement">
            \item <xsl:value-of select="."/>
          </xsl:for-each>
        \end{itemize}
      \end{itemize}
    </xsl:for-each>

    \subsection*{Professional Development}
    \bulletlist
    \begin{itemize}<xsl:text> </xsl:text>
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
        \hfill <xsl:value-of select="date"/>
      </xsl:for-each>
    \end{itemize}

    \subsection*{Education}<xsl:text> </xsl:text>
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
          <xsl:if test="position() != last()">, </xsl:if>
        </xsl:for-each>
        --- 
        \textbf{Languages:}
          <xsl:for-each select="resume/language-list/language-entry">
            <xsl:value-of select="language"/>
            <xsl:if test="position() != last()">, </xsl:if>
          </xsl:for-each>.

    <xsl:text>\end{document}</xsl:text>
  </xsl:template>

  <xsl:template name="format-date-range">
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
