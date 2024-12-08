<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xs="http://www.w3.org/2001/XMLSchema"
        queryBinding="xslt2">

  <ns uri="#functions" prefix="f"/>

  <pattern>
    <rule context="//*:paragraph[not(child::*:caption) and not(parent::*:footnote-definition)]//text()">
      <let name="sentences" value="tokenize(.,'^\s+[\u4E00-\u9FFFA-Za-z\,\s]+[.?!]$\s',';j')"/>
      <let name="words" value="for $x in $sentences return count(tokenize($x,'\s+'))"/>
      <report test="every $n in (for $w in $words return $w) satisfies $n gt 25">
        This sentence has <value-of select="$words"/>:
        <em><value-of select="$sentences"/></em>
      </report>
    </rule>
  </pattern>

</schema>
