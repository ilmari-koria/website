<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                version="2.0">

  <xsl:output method="text"
              encoding="UTF-8"
              indent="no"
              omit-xml-declaration="yes"/>

  <xsl:template match="/">
    <xsl:text>
body {
    max-width: 50rem;
    margin: auto;
    padding: 0.5rem;
    font-family: serif;
}

h1,h2,h3,h4,h5 {
    font-family: sans-serif;
}

.website-title {
    display: flex;
    align-items: center;
    margin-bottom: 0.5rem;
}

.website-title h1 {
    margin: 0;
}

#logo {
    max-height: 50px;
    margin-right: 1rem;
}

#preamble {
    margin: 2rem 0 2.5rem 0;
}

#preamble ul {
    list-style-type: none;
    padding: 0;
    margin: 0;
}

#preamble ul li {
    display: inline;
    margin-right: 0.5rem;
}

p {
    text-align: justify;
    text-justify: inter-word;
    line-height: 175%;
}

#about p {
    line-height: initial;
    text-align: initial;
    text-justify: initial;
}

sup {
    padding: 0;
    margin-left: -2.5px;
}

.post-title {
    margin-bottom: 0;
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
    padding: 0 0.5rem 0.25rem 0;
}

#references td {
    padding: 0 1rem 0.85rem 0;
}

.footnotes td {
    padding: 0 1rem 0.85rem 0;
}


.book-title {
    font-style: italic;
    font-size: 110%;
}

.reading-list p {
    margin: 0;
    width: 80%;
    text-align: initial;
    text-justify: initial;
    line-height: initial;
}

.reading-list-done {
    font-size: small;
    border-collapse: collapse;
    width: 100%;
}

.reading-list-done td {
    padding: 0 0.25rem 0 0.25rem;
    border: solid 1px black; 
}

.reading-list-done tr {
    border: none; 
}

.reading-list-done tr:nth-child(even) {
    background-color: gainsboro;
}

.image-column img {
    max-width: 115px;
}

ul.reading-list {
    font-size: smaller;
}

/* media rules */
@media (max-width: 768px) {
    body {
        font-size: 120%;
        margin: 1rem;
    }

    #container {
        display: initial;
    }

    #preamble h1 {
        margin-bottom: 1rem;
    }

    #preamble ul li {
        display: block;
        margin-right: initial;
        margin-bottom: 1rem;
    }

    p {
        text-align: initial;
        text-justify: initial;
    }

    #content {
        width: initial;
        margin: 2rem 0 0 0;
        border: initial
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
    </xsl:text>
  </xsl:template>
</xsl:stylesheet>
