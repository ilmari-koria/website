<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:sch="http://purl.oclc.org/dsdl/schematron"
                exclude-result-prefixes="xs sch" 
                version="2.0">

  <xsl:variable name="sch-errors">
    <errors xmlns="">
      <xsl:for-each select="//*:text[
                            parent::*:successful-report
                            and not(parent::*:successful-report[@role='warning'])
                            and not(parent::*:successful-report[@role='information'])
                            and not(parent::*:successful-report[@role='info'])
                            or
                            parent::*:failed-assert
                            and not(parent::*:failed-assert[@role='warning'])
                            ]">
        <message>
          <xsl:value-of select="."/>
          <xsl:text>  </xsl:text>
        </message>
      </xsl:for-each>
    </errors>
  </xsl:variable>

  <xsl:variable name="sch-warnings">
    <warnings xmlns="">
      <xsl:for-each select="//*:text[parent::*:failed-assert[@role='warning']] | //*:text[parent::*:successful-report[@role='warning']]">
        <message>
          <xsl:value-of select="."/>
          <xsl:text>  </xsl:text>
        </message>
      </xsl:for-each>
    </warnings>
  </xsl:variable>

  <xsl:template match="/">
    <html>
      <head>
        <style>
          <xsl:text>
            body { margin: auto; width: 65rem; }
            h1,h2,h3,h4 { font-family: sans-serif; }
            .toc {display: flex;}
            .toc > div {margin-right: 1rem;}
          </xsl:text>
        </style>
      </head>
      <body>
        <h1>Schematron messages for </h1>
        <!-- ToC starts here -->
        <div class="toc">
          <xsl:if test="$sch-errors/errors/message != ''">
          <div class="toc-errors">
            <h3>❌ ERRORS [<xsl:value-of select="count($sch-errors/errors/message)"/>]</h3>
            <ul class="toc-list">
              <xsl:for-each-group select="$sch-errors/errors/message" group-by="substring-before(., ' ')">
                <xsl:sort select="substring-before(substring-after(current-grouping-key(), '['), ']')" />
                <xsl:for-each select="current-group()[1]">
                  <li>
                    <a href="#warning_{generate-id()}">
                      <xsl:value-of select="substring-before(substring-after(current-grouping-key(), '['), ']')"/>
                    </a>
                  </li>
                </xsl:for-each>
              </xsl:for-each-group>
            </ul>
          </div>
          </xsl:if>
          <div class="toc-warnings">
            <h3>⚠️ WARNINGS [<xsl:value-of select="count($sch-warnings/warnings/message)"/>]</h3>
            <ul class="toc-list">
              <xsl:for-each-group select="$sch-warnings/warnings/message" group-by="substring-before(., ' ')">
                <xsl:sort select="substring-before(substring-after(current-grouping-key(), '['), ']')" />
                <xsl:for-each select="current-group()[1]">
                  <li>
                    <a href="#warning_{generate-id()}">
                      <xsl:value-of select="substring-before(substring-after(current-grouping-key(), '['), ']')"/>
                    </a>
                  </li>
                </xsl:for-each>
              </xsl:for-each-group>
            </ul>
          </div>
        </div>
        <!-- ToC ends here -->
        <xsl:if test="$sch-errors/errors/message != ''">
        <div class="errors">
          <h2>ERRORS: [<xsl:value-of select="count($sch-errors/errors/message)"/>]</h2>
          <xsl:for-each-group select="$sch-errors/errors/message" group-by="substring-before(., ' ')">
            <xsl:sort select="substring-before(substring-after(current-grouping-key(), '['), ']')" />
            <h3 id="warning_{generate-id()}">❌
              <xsl:value-of select="substring-before(substring-after(current-grouping-key(), '['), ']')"/>:
            </h3>
            <ul>
              <xsl:for-each select="current-group()">
                <li>
                  <input type="checkbox" id="checkbox_{position()}" />
                  <label for="checkbox_{position()}">
                    <xsl:value-of select="substring-after(., ' ')"/>
                  </label>
                </li>
              </xsl:for-each>
            </ul>
          </xsl:for-each-group>
        </div>
        </xsl:if>
        <div class="warnings">
          <h2>WARNINGS [<xsl:value-of select="count($sch-warnings/warnings/message)"/>]</h2>
          <xsl:for-each-group select="$sch-warnings/warnings/message" group-by="substring-before(., ' ')">
            <xsl:sort select="substring-before(substring-after(current-grouping-key(), '['), ']')" />
            <h3 id="warning_{generate-id()}">⚠️
              <xsl:value-of select="substring-before(substring-after(current-grouping-key(), '['), ']')"/>:
            </h3>
            <ul>
              <xsl:for-each select="current-group()">
                <li>
                  <input type="checkbox" id="checkbox_{position()}" />
                  <label for="checkbox_{position()}">
                    <xsl:value-of select="substring-after(., ' ')"/>
                  </label>
                </li>
              </xsl:for-each>
            </ul>
          </xsl:for-each-group>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>


