<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0">

  <xsl:template name="style">
    <style>
      <xsl:text>
        body {
        max-width: 50rem;
        margin: auto;
        padding: 0.5rem;
        }

        nav ul {
        list-style-type: none;
        padding: 0;
        margin: 0;
        }

        nav ul li {
        display: inline;
        margin-right: 0.5rem;
        }

        p {
        text-align: justify;
        text-justify: inter-word;
        line-height: 175%;
        }

        sup {
        padding: 0;
        margin-left: -2.5px;
        }

        img {
        height: auto;
        max-width: 350px;
        }

        pre {
        background-color: aliceblue;
        padding: 1.5rem;
        margin: 1rem;
        }
        
        figure {
        display: block;
        width: auto;
        margin: 0.25rem;
        padding: 0;
        }

        figure figcaption {
        font-size: 85%;
        }
 
        table {
        border-collapse: collapse;
        }

        tr:nth-child(even) {
        background-color: WhiteSmoke;
        }
       
        td img {
        max-width: 95px;
        }

        td p {
        text-align: initial;
        text-justify: initial;
        line-height: initial;
        }
        
        td {
        vertical-align: top;
        padding: 0 0.5rem 0.25rem 0;
        }

        summary p, summary h2, summary h3 {
            display: inline;
        }

        /* media rules */
        @media (max-width: 768px) {
        body {
        font-size: 120%;
        margin: 1rem;
        }
      
        nav ul li {
        display: block;
        margin-right: initial;
        margin-bottom: 1rem;
        }

        p {
        text-align: initial;
        text-justify: initial;
        }
      }
      </xsl:text>
    </style>
  </xsl:template>
</xsl:stylesheet>
