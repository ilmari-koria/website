<xsl:transform version="3.0" expand-text="yes"
               xmlns:sch="http://purl.oclc.org/dsdl/schematron"
               xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output indent="yes"/>

  <xsl:mode on-no-match="shallow-skip"/>

  <xsl:param name="phase" as="xs:string">#DEFAULT</xsl:param>

  <xsl:include href="framework/transpile.xsl"/>

  <xsl:template match="sch:schema" as="element(xsl:stylesheet)">
    <xsl:variable name="effective-phase" as="xs:string">
      <xsl:choose>
        <xsl:when test="$phase = ('', '#DEFAULT')">
          <xsl:value-of select="(@defaultPhase, '#ALL')[1]"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$phase"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="schema" as="element(xsl:stylesheet)">
      <xsl:element name="xsl:stylesheet">
        <xsl:attribute name="version">3.0</xsl:attribute>
        <xsl:sequence select="namespace::node()"/>
        <xsl:for-each select="sch:ns">
          <xsl:namespace name="{@prefix}" select="@uri"/>
        </xsl:for-each>
        <xsl:apply-templates select="node()" mode="#current">
          <xsl:with-param name="effective-phase" as="xs:string" tunnel="yes" select="$effective-phase"/>
        </xsl:apply-templates>
      </xsl:element>
    </xsl:variable>

    <xsl:variable name="schema-stylesheet" as="element(xsl:stylesheet)">
      <xsl:apply-templates select="$schema" mode="Q{https://doi.org/10.5281/zenodo.4834190}transpile"/>
    </xsl:variable>

    <xsl:apply-templates select="$schema-stylesheet" mode="postprocess"/>

  </xsl:template>

  <xsl:template match="sch:phase" as="element(xsl:variable)">
    <xsl:param name="effective-phase" as="xs:string" required="yes" tunnel="yes"/>
    <xsl:if test="$effective-phase = @id">
      <xsl:apply-templates select="sch:let" mode="#current"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="sch:let[not(ancestor::sch:pattern)]" as="element(xsl:param)">
    <xsl:element name="xsl:param">
      <xsl:sequence select="@name, @as"/>
      <xsl:if test="@value">
        <xsl:attribute name="select" select="@value"/>
      </xsl:if>
      <xsl:apply-templates select="node()" mode="#current"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="sch:pattern/sch:let | sch:phase/sch:let | sch:rule/sch:let" as="element(xsl:variable)">
    <xsl:element name="xsl:variable">
      <xsl:sequence select="@name, @as"/>
      <xsl:if test="@value">
        <xsl:attribute name="select" select="@value"/>
      </xsl:if>
      <xsl:apply-templates select="node()" mode="#current"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[ancestor::sch:let[not(@value)]]">
    <xsl:element name="xsl:element">
      <xsl:attribute name="name" select="local-name()"/>
      <xsl:attribute name="namespace" select="namespace-uri()"/>
      <xsl:apply-templates mode="#current"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="sch:rule[@abstract = 'true']"/>

  <xsl:template match="sch:rule/sch:extends[@rule]" as="element()*">
    <xsl:variable name="super" as="element(sch:rule)?" select="../../sch:rule[@abstract = 'true'][@id = current()/@rule]"/>
    <xsl:if test="empty($super)">
      <xsl:message terminate="yes">
        <xsl:text expand-text="yes">Cannot find abstract rule '{@rule}' in current pattern</xsl:text>
      </xsl:message>
    </xsl:if>
    <xsl:apply-templates select="$super/*" mode="#current"/>
  </xsl:template>

  <xsl:template match="sch:pattern" as="element()*">
    <xsl:param name="effective-phase" as="xs:string" required="yes" tunnel="yes"/>
    <xsl:if test="$effective-phase = '#ALL' or (@id = ../sch:phase[@id = $effective-phase]/sch:active/@pattern)">
      <xsl:apply-templates select="sch:let" mode="#current"/>
      <xsl:element name="constraint" namespace="https://doi.org/10.5281/zenodo.4834190">
        <svrl:active-pattern>
          <xsl:sequence select="@*"/>
        </svrl:active-pattern>
        <xsl:apply-templates select="node() except sch:let" mode="#current"/>
      </xsl:element>
    </xsl:if>
  </xsl:template>

  <xsl:template match="sch:rule" as="element(Q{https://doi.org/10.5281/zenodo.4834190}context)">
    <xsl:element name="context" namespace="https://doi.org/10.5281/zenodo.4834190">
      <xsl:sequence select="namespace::node()"/>
      <xsl:attribute name="match" select="@context"/>
      <xsl:sequence select="@* except @match"/>
      <svrl:fired-rule>
        <xsl:sequence select="@*"/>
      </svrl:fired-rule>
      <xsl:apply-templates select="node()" mode="#current"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="sch:assert" as="element(Q{https://doi.org/10.5281/zenodo.4834190}assert)">
    <xsl:element name="assert" namespace="https://doi.org/10.5281/zenodo.4834190">
      <xsl:sequence select="namespace::node()"/>
      <xsl:sequence select="@*"/>
      <svrl:failed-assert>
        <xsl:sequence select="@*"/>
        <xsl:apply-templates select="node()" mode="#current"/>
      </svrl:failed-assert>
      <xsl:apply-templates select="ancestor::sch:schema/sch:diagnostics/sch:diagnostic[@id = tokenize(current()/@diagnostics)]" mode="#current"/>
      <xsl:apply-templates select="ancestor::sch:schema/sch:properties/sch:property[@id = tokenize(current()/@properties)]" mode="#current"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="sch:report" as="element(Q{https://doi.org/10.5281/zenodo.4834190}assert)">
    <xsl:element name="assert" namespace="https://doi.org/10.5281/zenodo.4834190">
      <xsl:sequence select="namespace::node()"/>
      <xsl:attribute name="test">not({@test})</xsl:attribute>
      <xsl:sequence select="@* except @test"/>
      <svrl:successful-report>
        <xsl:attribute name="test">not({@test})</xsl:attribute>
        <xsl:sequence select="@* except @test"/>
        <xsl:apply-templates select="node()" mode="#current"/>
      </svrl:successful-report>
      <xsl:apply-templates select="ancestor::sch:schema/sch:diagnostics/sch:diagnostic[@id = tokenize(current()/@diagnostics)]" mode="#current"/>
      <xsl:apply-templates select="ancestor::sch:schema/sch:properties/sch:property[@id = tokenize(current()/@properties)]" mode="#current"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="sch:value-of" as="element(xsl:value-of)">
    <xsl:element name="xsl:value-of">
      <xsl:sequence select="@select"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="sch:name[not(@path)]" as="element(xsl:value-of)">
    <xsl:element name="xsl:value-of">
      <xsl:attribute name="select">name()</xsl:attribute>
    </xsl:element>
  </xsl:template>

  <xsl:template match="sch:name[@path]" as="element(xsl:value-of)">
    <xsl:element name="xsl:value-of">
      <xsl:attribute name="select" select="@path"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="sch:property">
    <svrl:property-reference property="{@id}">
      <xsl:sequence select="@role, @scheme"/>
      <xsl:apply-templates mode="#current"/>
    </svrl:property-reference>
  </xsl:template>

  <xsl:template match="sch:diagnostic">
    <svrl:diagnostic-reference diagnostic="{@id}">
      <svrl:text>
        <xsl:sequence select="@xml:lang"/>
        <xsl:apply-templates mode="#current"/>
      </svrl:text>
    </svrl:diagnostic-reference>
  </xsl:template>

  <xsl:template match="xsl:key | xsl:function | xsl:accumulator">
    <xsl:sequence select="."/>
  </xsl:template>

  <!-- Postprocess -->

  <xsl:template match="xsl:stylesheet" mode="postprocess">
    <xsl:copy>
      <xsl:sequence select="@*"/>
      <xsl:sequence select="node()"/>
      <xsl:element name="output" namespace="http://www.w3.org/1999/XSL/Transform">
        <xsl:attribute name="indent">yes</xsl:attribute>
      </xsl:element>
      <xsl:element name="template" namespace="http://www.w3.org/1999/XSL/Transform">
        <xsl:attribute name="match">/</xsl:attribute>
        <xsl:element name="call-template" namespace="http://www.w3.org/1999/XSL/Transform">
          <xsl:attribute name="name">Q{{https://doi.org/10.5281/zenodo.4834190}}validate</xsl:attribute>
        </xsl:element>
      </xsl:element>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="Q{https://doi.org/10.5281/zenodo.4834190}report" mode="postprocess">
    <svrl:schematron-output>
      <xsl:apply-templates select="@*" mode="#current"/>
      <xsl:apply-templates select="node()" mode="#current"/>
    </svrl:schematron-output>
  </xsl:template>

</xsl:transform>
