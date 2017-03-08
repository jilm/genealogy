<?xml version="1.0" ?>



<!--

  Takes a list of persons and generate genealogy genealogytree graph

-->



<xsl:stylesheet version="2.0"
  
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  
                xmlns:my="http://www.lidinsky.cz" >

  

  <xsl:output method="text" encoding="CP852" />

  

  <xsl:variable name="CR" select="codepoints-to-string((13))" />
  <xsl:variable name="LF" select="codepoints-to-string((10))" />
  <xsl:variable name="NL" select="concat($CR, $LF)" />

  <xsl:template match="/">
    <xsl:apply-templates select="//person">
      <xsl:sort select="@id" />
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="name">
    <xsl:value-of select="concat(second, ' ', first)" />
  </xsl:template>

  <xsl:template match="birth[normalize-space(date) and normalize-space(place)]">
    <xsl:value-of select="concat($NL, '  * ', date, ', ', place)" />
  </xsl:template>

  <xsl:template match="birth[normalize-space(date) and not(place)]">
    <xsl:value-of select="concat($NL, '  * ', date)" />
  </xsl:template>

  <xsl:template match="birth[not(date) and normalize-space(place)]">
    <xsl:value-of select="concat($NL, '  * ', place)" />
  </xsl:template>

  <xsl:template match="death[date and place]">
    <xsl:value-of select="concat($NL, '  + ', date, ', ', place)" />
  </xsl:template>

  <xsl:template match="death[date and not(place)]">
    <xsl:value-of select="concat($NL, '  + ', date)" />
  </xsl:template>

  <xsl:template match="death[not(date) and place]">
    <xsl:value-of select="concat($NL, '  + ', place)" />
  </xsl:template>

  <xsl:template match="father[@href]">
    <xsl:variable name="id" select="@href" />
    <xsl:variable name="father-name" >
      <xsl:apply-templates select="//person[@id = $id]/name" />
    </xsl:variable>
    <xsl:value-of select="concat($NL, '  Otec: ', $father-name)" />
  </xsl:template>

  <xsl:template match="mather[@href]">
    <xsl:variable name="id" select="@href" />
    <xsl:variable name="father-name" >
      <xsl:apply-templates select="//person[@id = $id]/name" />
    </xsl:variable>
    <xsl:value-of select="concat($NL, '  Matka: ', $father-name)" />
  </xsl:template>

  <xsl:template match="person">
    <xsl:variable name="pname">
      <xsl:apply-templates select="name" />
    </xsl:variable>
    <xsl:value-of select="$pname" />
    <xsl:apply-templates select="birth" />
    <xsl:apply-templates select="death" />
    <xsl:apply-templates select="father" />
    <xsl:apply-templates select="mather" />
    <xsl:value-of select="codepoints-to-string((13, 10))" />
  </xsl:template>

  <xsl:template match="text()" />

</xsl:stylesheet>