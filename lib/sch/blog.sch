<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xs="http://www.w3.org/2001/XMLSchema"
        queryBinding="xslt2">

  <ns uri="#functions" prefix="f"/>

  <xsl:function name="f:combine-text" as="xs:string">
    <xsl:param name="nodes" as="node()*"/>
    <xsl:value-of select="string-join($nodes, '')"/>
  </xsl:function>
  
  <xsl:function name="f:tokenize-sentences" as="xs:string*">
    <xsl:param name="text" as="xs:string"/>
    <xsl:variable name="cleaned-text" select="replace($text, '[^()]*[.]', '')"/>
    <xsl:variable name="sentences" select="tokenize($cleaned-text, '[.!?]\s*')"/>
    <xsl:value-of select="$sentences"/>
  </xsl:function>

  <xsl:function name="f:count-words-in-sentence" as="xs:int">
    <xsl:param name="sentence" as="xs:string"/>
    <xsl:variable name="word-count" select="count(tokenize($sentence, '\s+'))"/>
    <xsl:value-of select="$word-count"/>
  </xsl:function>

  <pattern>
    <rule context="//*:paragraph[not(child::*:caption) and not(parent::*:footnote-definition)]">
      <let name="combined-string" value="f:combine-text(.)"/>
      <let name="sentences" value="f:tokenize-sentences($combined-string)"/>
      <let name="words" value="f:count-words-in-sentence($sentences)"/>
      <report test="every $n in (for $w in $words return $w) satisfies $n gt 25">
        This sentence has more than 25 words (<value-of select="$words"/>): <em><value-of select="$sentences"/></em>/>
      </report>
    </rule>
  </pattern>

</schema>
