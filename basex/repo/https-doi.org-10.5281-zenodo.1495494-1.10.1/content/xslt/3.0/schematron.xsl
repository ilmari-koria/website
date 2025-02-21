<xsl:transform version="3.0" expand-text="yes"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="../2.0/pipeline-for-svrl.xsl"/>

  <xsl:param name="schema" as="xs:string" required="true"/>
  <xsl:param name="document" as="xs:string?" required="false"/>
  <xsl:param name="document-uri" as="xs:string?" required="false"/>
  <xsl:param name="phase" as="xs:string?" required="false"/>
  <xsl:param name="schxslt.validate.params" as="map(xs:QName, item()*)" select="map{}"/>

  <xsl:template name="main">

    <xsl:if test="exists($document) and exists($document-uri)">
      <xsl:message terminate="yes">
        The parameters 'document' and 'document-uri' are mutually exclusive.
      </xsl:message>
    </xsl:if>
    <xsl:if test="empty($document) and empty($document-uri)">
      <xsl:message terminate="yes">
        One of the parameter 'document' or 'document-uri' is required.
      </xsl:message>
    </xsl:if>

    <xsl:variable name="schema-compiled" as="element(xsl:transform)">
      <xsl:apply-templates select="doc($schema)"/>
    </xsl:variable>
    <xsl:variable name="validate" as="map(xs:string, item()*)">
      <xsl:map>
        <xsl:map-entry key="'stylesheet-node'" select="$schema-compiled"/>
        <xsl:map-entry key="'stylesheet-base-uri'" select="$schema"/>
        <xsl:choose>
          <xsl:when test="exists($document-uri)">
            <xsl:map-entry key="'initial-template'" select="QName((), 'main')"/>
            <xsl:map-entry key="'stylesheet-params'">
              <xsl:map>
                <xsl:map-entry key="QName((), 'schxslt.validate.initial-document-uri')" select="$document-uri"/>
              </xsl:map>
            </xsl:map-entry>
          </xsl:when>
          <xsl:when test="exists($document)">
            <xsl:map-entry key="'source-node'" select="doc($document)"/>
          </xsl:when>
        </xsl:choose>
      </xsl:map>
    </xsl:variable>
    <xsl:variable name="validation-result" as="map(*)" select="transform($validate)"/>
    <xsl:sequence select="$validation-result?output"/>
  </xsl:template>

</xsl:transform>
