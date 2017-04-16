<?xml version="1.0" encoding="utf-8"?>

<!--

  Takes an input data file and generate latex source for full
  latex person list.

-->

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:my="http://www.lidinsky.cz" >

  <xsl:import href="latex.xsl" />
  <xsl:import href="placeFormat.xsl" />
  <xsl:import href="labels_CZ.xsl" />
  <xsl:import href="formLatexBirth.xsl" />
  <xsl:import href="formLatexDeath.xsl" />
  <xsl:import href="formLatexPerson.xsl" />
  <xsl:import href="formLatexCite.xsl" />
  <xsl:import href="formLatexDate.xsl" />
  <xsl:import href="functions.xsl" />
  <xsl:import href="nameFormat.xsl" />
  

  <xsl:output method="text" encoding="utf-8" />

  <xsl:variable name="CR" select="codepoints-to-string((13))" />
  <xsl:variable name="LF" select="codepoints-to-string((10))" />
  <xsl:variable name="NL" select="concat($CR, $LF)" />

  <xsl:template match="/">
    <xsl:for-each select="//person" >
      <xsl:apply-templates select="." mode="list" /><xsl:text>\\</xsl:text>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="father[@href]">
    <xsl:variable name="id" select="@href" />
    <xsl:variable name="father-name" >
      <xsl:apply-templates select="//person[@id = $id]/name" />
    </xsl:variable>
    <xsl:value-of select="concat($FATHER-LABEL, ' ', $father-name)" />
  </xsl:template>

  <xsl:template match="mather[@href]">
    <xsl:variable name="id" select="@href" />
    <xsl:variable name="father-name" >
      <xsl:apply-templates select="//person[@id = $id]/name" />
    </xsl:variable>
    <xsl:value-of select="concat($MATHER-LABEL, ' ', $father-name)" />
  </xsl:template>

  <xsl:template match="text()" />

</xsl:stylesheet>
