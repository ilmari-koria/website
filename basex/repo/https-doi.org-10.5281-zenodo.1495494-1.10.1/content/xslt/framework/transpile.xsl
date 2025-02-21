<!--

MIT License

Copyright (c) 2021 David Maus <dmaus@dmaus.name>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
-->
<xsl:transform version="3.0"
               default-mode="schematron-framework:transpile"
               xmlns:alias="http://www.w3.org/1999/XSL/TransformAlias"
               xmlns:schematron-framework="https://doi.org/10.5281/zenodo.4834190"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:namespace-alias result-prefix="xsl" stylesheet-prefix="alias"/>

  <xsl:param name="streamable" as="xs:boolean" select="false()"/>
  <xsl:param name="streamable.burst" as="xs:string?"/>

  <xsl:param name="validation-style" static="yes" as="xs:string" select="'template-mode'"/>

  <xsl:mode name="schematron-framework:transpile" on-no-match="shallow-copy"/>

  <xsl:template match="*[schematron-framework:constraint]" as="element()" mode="schematron-framework:transpile">

    <xsl:if test="$streamable.burst and not($streamable.burst = ('copy-of', 'snapshot'))">
      <xsl:variable name="message" as="xs:string" expand-text="yes">
        Unknown or invalid value for parameter 'streamable.burst': Expected one
        of 'copy-of' or 'snapshot', got '{$streamable.burst}'.
      </xsl:variable>
      <xsl:message terminate="yes" select="normalize-space($message)"/>
    </xsl:if>

    <xsl:copy>
      <xsl:sequence select="namespace::node()"/>
      <xsl:sequence select="@*"/>
      <xsl:apply-templates select="node()" mode="schematron-framework:transpile"/>
    </xsl:copy>

  </xsl:template>

  <xsl:template match="schematron-framework:constraint[empty(preceding::schematron-framework:constraint)]" as="node()+" use-when="$validation-style eq 'next-match'">

    <alias:mode streamable="{$streamable}"/>
    <alias:mode name="schematron-framework:validate" on-no-match="shallow-skip" streamable="{$streamable and not($streamable.burst)}"/>
    <xsl:if test="$streamable.burst">
      <alias:mode name="schematron-framework:burst" on-no-match="shallow-skip" streamable="true" />
    </xsl:if>

    <alias:template name="schematron-framework:validate">
      <schematron-framework:report>
        <alias:apply-templates select="." mode="schematron-framework:{if ($streamable.burst) then 'burst' else 'validate'}"/>
      </schematron-framework:report>
    </alias:template>

    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="schematron-framework:constraint" as="node()+" use-when="$validation-style eq 'next-match'">

    <xsl:for-each select="schematron-framework:context">

      <xsl:if test="$streamable.burst">
        <alias:template match="{@match}" priority="{count(following::schematron-framework:context)}" mode="schematron-framework:burst">
          <alias:apply-templates select="{$streamable.burst}(.)" mode="schematron-framework:validate"/>
        </alias:template>
      </xsl:if>

      <alias:template match="{@match}" priority="{count(following::schematron-framework:context)}" mode="schematron-framework:validate">
        <alias:param name="schematron-framework:constraint" as="xs:string*"/>

        <xsl:apply-templates select="node() except schematron-framework:assert" mode="#current"/>

        <alias:choose>
          <alias:when test="$schematron-framework:constraint[. = '{generate-id(..)}']">
            <alias:next-match>
              <alias:with-param name="schematron-framework:constraint" as="xs:string*" select="$schematron-framework:constraint"/>
            </alias:next-match>
          </alias:when>
          <alias:otherwise>
            <xsl:apply-templates select="schematron-framework:assert" mode="#current"/>
            <alias:next-match>
              <alias:with-param name="schematron-framework:constraint" as="xs:string*" select="($schematron-framework:constraint, '{generate-id(..)}')"/>
            </alias:next-match>
          </alias:otherwise>
        </alias:choose>
      </alias:template>

    </xsl:for-each>
  </xsl:template>

  <xsl:template match="schematron-framework:constraint[empty(preceding::schematron-framework:constraint)]" as="node()+" use-when="$validation-style eq 'template-mode'">
    <alias:template name="schematron-framework:validate">
      <schematron-framework:report>
        <xsl:for-each select="(., following::schematron-framework:constraint)">
          <alias:apply-templates select="." mode="schematron-framework:{if ($streamable.burst) then 'burst' else 'validate'}.{generate-id()}"/>
        </xsl:for-each>
      </schematron-framework:report>
    </alias:template>

    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="schematron-framework:constraint" as="node()+" use-when="$validation-style eq 'template-mode'">
    <alias:mode on-no-match="shallow-skip" name="schematron-framework:validate.{generate-id()}"/>
    <xsl:if test="$streamable.burst">
      <alias:mode on-no-match="shallow-skip" name="schematron-framework:burst.{generate-id()}" />
    </xsl:if>
    <xsl:for-each select="schematron-framework:context">

      <xsl:if test="$streamable.burst">
        <alias:template match="{@match}" priority="{count(following::schematron-framework:context)}" mode="schematron-framework:burst.{generate-id(..)}">
          <alias:apply-templates select="{$streamable.burst}(.)" mode="schematron-framework:validate.{generate-id(..)}"/>
        </alias:template>
      </xsl:if>

      <alias:template match="{@match}" priority="{count(following::schematron-framework:context)}" mode="schematron-framework:validate.{generate-id(..)}">
        <xsl:apply-templates select="node()" mode="#current"/>
        <alias:apply-templates select="@* | node()" mode="#current"/>
      </alias:template>

    </xsl:for-each>
  </xsl:template>

  <xsl:template match="schematron-framework:constraint[empty(preceding::schematron-framework:constraint)]" as="node()+" use-when="$validation-style eq 'accumulator'">
    <xsl:if test="$streamable.burst">
      <xsl:message terminate="yes" expand-text="yes">
        <xsl:text>The validation style '{$validation-style}' does not support burst-mode streaming.</xsl:text>
      </xsl:message>
    </xsl:if>

    <alias:mode on-no-match="shallow-skip" name="schematron-framework:validate" streamable="{$streamable}"/>
    <alias:mode on-no-match="shallow-skip" streamable="{$streamable}">
      <xsl:attribute name="use-accumulators">
        <xsl:value-of select="for $constraint in (., following::schematron-framework:constraint) return concat('schematron-framework:', generate-id($constraint))"/>
      </xsl:attribute>
    </alias:mode>

    <alias:template name="schematron-framework:validate">

      <alias:apply-templates mode="schematron-framework:validate"/>

      <schematron-framework:report>
        <xsl:for-each select="(., following::schematron-framework:constraint)">
          <alias:sequence select="accumulator-after('schematron-framework:{generate-id()}')"/>
        </xsl:for-each>
      </schematron-framework:report>

    </alias:template>

    <xsl:next-match/>

  </xsl:template>

  <xsl:template match="schematron-framework:constraint" as="node()+" use-when="$validation-style eq 'accumulator'">
    <alias:accumulator name="schematron-framework:{generate-id()}" initial-value="()">
      <!-- Workaround for bug in Saxon 10.3 -->
      <xsl:attribute name="streamable" select="$streamable"/>
      <xsl:for-each select="schematron-framework:context">
        <xsl:sort select="position()" order="descending"/>
        <alias:accumulator-rule match="{@match}">
          <xsl:apply-templates select="node() except schematron-framework:assert" mode="#current"/>
          <alias:sequence>
            <alias:sequence select="$value"/>
            <xsl:apply-templates select="schematron-framework:assert" mode="#current"/>
          </alias:sequence>
        </alias:accumulator-rule>
      </xsl:for-each>
    </alias:accumulator>
  </xsl:template>

  <xsl:template match="schematron-framework:assert" as="element(xsl:if)" mode="schematron-framework:transpile">
    <alias:if test="not({@test})">
      <xsl:sequence select="node()"/>
    </alias:if>
  </xsl:template>

</xsl:transform>
