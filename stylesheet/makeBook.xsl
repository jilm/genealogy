<?xml version="1.0" ?>

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="substituteValue.xsl" />
  <xsl:import href="nameFormat.xsl" />
  <xsl:import href="latex.xsl" />
  <xsl:import href="formLatexBirth.xsl" />
  <xsl:import href="functions.xsl" />
  <xsl:import href="formLatexDate.xsl" />
  <xsl:import href="formLatexPerson.xsl" />
  <xsl:import href="labels_CZ.xsl" />

  <xsl:strip-space elements="footnote person p" />

  <xsl:output method="text" encoding="utf-8" />

  <xsl:variable name="index" select="doc('../build/index.xml')" />

  <xsl:template match="/html">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="body">
      <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="head">
      <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="p">
      <xsl:variable name="para">
          <xsl:apply-templates />
      </xsl:variable>
      <xsl:variable name="temp" select="replace($para, '\s+\\footnote', '\\footnote')" />
      <xsl:variable name="temp2"
           select="replace($temp, '\.{3}', '\\ldots')" />
      <xsl:variable name="temp3"
           select="replace($temp2, '\s+\.', '.')" />
      <xsl:variable name="temp4"
           select="replace($temp3, '\s+,', ',')" />
      <xsl:value-of select="normalize-space($temp4)"/>\par
  </xsl:template>

  <xsl:template match="h1">
    \chapter{<xsl:apply-templates />}
  </xsl:template>

  <xsl:template match="person[@href]">
    <xsl:variable name="ref" select="@href" />
    <xsl:apply-templates />
    <xsl:value-of select="concat('\index{', $index//index-item[@id=$ref]/text(), '}')" />
  </xsl:template>

  <xsl:template match="footnote">
    \footnote{<xsl:apply-templates />}
  </xsl:template>

</xsl:stylesheet>
