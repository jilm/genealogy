<?xml version="1.0" encoding="utf-8"?>

<!--

  Takes source data, extracts source references ant translates them
  into the bibtex form.

-->

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:my="http://www.lidinsky.cz" >
  

  <xsl:output method="text" encoding="utf-8" />

  <xsl:variable name="CR" select="codepoints-to-string((13))" />
  <xsl:variable name="LF" select="codepoints-to-string((10))" />
  <xsl:variable name="NL" select="concat($CR, $LF)" />

  <xsl:template match="/">
    <xsl:apply-templates select="//matrika">
      <xsl:sort select="@id" />
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="matrika">
    @BOOK{<xsl:value-of select="@id" />,
      author = "<xsl:apply-templates select="author" />",
      title = "<xsl:apply-templates select="title" />",
      year = "<xsl:apply-templates select="year" />"
    }
  </xsl:template>

</xsl:stylesheet>
