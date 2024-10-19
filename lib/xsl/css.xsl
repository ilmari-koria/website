<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                version="2.0">

  <xsl:strip-space elements="*"/>

  <xsl:output method="text"
              encoding="UTF-8"
              indent="no"
              omit-xml-declaration="yes"/>

  <xsl:template match="/">
body {
    max-width: 65rem;
    margin: auto; /* top, right, bottom, and left */
    font-family: serif;
}

p {
    text-align: justify;
    text-justify: inter-word;
    line-height: 175%;
}

#recent-posts td:nth-child(1)::before {
    content:"📌 ";
    padding-right: 0.25rem;
    font-size: 75%;
}

.post-title {
    margin-bottom: 0;
    font-size: 200%
}

.post-date {
    margin-top: 0.45rem;
    font-style: italic;
}

#about p {
    text-align: initial;
    text-justify: initial;
}

#about img {
    height: auto;
    max-width: 185px;
    border: 2px solid black;
}

#about figcaption {
    font-style: italic;
}

img {
    height: auto;
    max-width: 350px;
}

figure {
    display: block;
    width: auto;
}

figure figcaption {
    font-size: 85%;
}

td {
    vertical-align: top;
    padding: 0 1rem 0.25rem 0;
}

#references td {
    padding: 0 1rem 0.85rem 0;
}

.footnotes td {
    padding: 0 1rem 0.85rem 0;
}

@media (max-width: 768px) {
    body {
        font-size: 120%;
    }

    #container {
        display: initial;
    }

    p {
        text-align: initial;
        text-justify: initial;
    }

    #preamble {
        width: initial;
        border: initial;
    }

    #content {
        width: initial;
        margin: 2rem 0 0 0;
        border: initial
    }

    h1,h2,h3,h4,h5 {
        font-size: 140%;
    }

    #container-index {
        display: initial;
    }

    #about {
        display: initial;
    }

    #profile-pic {
        display: initial;
        margin: initial;
    }

    #profile-pic figcaption {
        text-align: left;
    }
}
  </xsl:template>

</xsl:stylesheet>

