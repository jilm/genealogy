<?xml version="1.0" encoding="utf-8"?>

<!--

  Takes an input data file and generate latex source for full
  latex person list.

-->

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:my="http://www.lidinsky.cz" >

  <xsl:output method="text" encoding="utf-8" />

  <xsl:variable name="CR" select="codepoints-to-string((13))" />
  <xsl:variable name="LF" select="codepoints-to-string((10))" />
  <xsl:variable name="NL" select="concat($CR, $LF)" />

  <xsl:template match="/">
\documentclass{article}
\usepackage[czech]{babel}
\usepackage[utf8]{inputenc}

\begin{document}

    <xsl:apply-templates select="//person">
      <xsl:sort select="@id" />
    </xsl:apply-templates>

\cite{MZA-10262}

\bibliography{sources}{}
\bibliographystyle{plain}

\end{document}
  </xsl:template>

  <xsl:template match="name">
    <xsl:value-of select="concat(second, ' ', first)" />
  </xsl:template>

  <xsl:template match="birth[normalize-space(date) and normalize-space(place)]">
    <xsl:value-of select="concat('  * ', date, ', ', place)" />
  </xsl:template>

  <xsl:template match="birth[normalize-space(date) and not(place)]">
    <xsl:value-of select="concat('  * ', date)" />
  </xsl:template>

  <xsl:template match="birth[not(date) and normalize-space(place)]">
    <xsl:value-of select="concat('  * ', place)" />
  </xsl:template>

  <xsl:template match="death[date and place]">
    <xsl:value-of select="concat('  + ', date, ', ', place)" />
  </xsl:template>

  <xsl:template match="death[date and not(place)]">
    <xsl:value-of select="concat('  + ', date)" />
  </xsl:template>

  <xsl:template match="death[not(date) and place]">
    <xsl:value-of select="concat('  + ', place)" />
  </xsl:template>

  <xsl:template match="father[@href]">
    <xsl:variable name="id" select="@href" />
    <xsl:variable name="father-name" >
      <xsl:apply-templates select="//person[@id = $id]/name" />
    </xsl:variable>
    <xsl:value-of select="concat('  Otec: ', $father-name)" />
  </xsl:template>

  <xsl:template match="mather[@href]">
    <xsl:variable name="id" select="@href" />
    <xsl:variable name="father-name" >
      <xsl:apply-templates select="//person[@id = $id]/name" />
    </xsl:variable>
    <xsl:value-of select="concat('  Matka: ', $father-name)" />
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
    \par
  </xsl:template>

  <xsl:template match="text()" />

</xsl:stylesheet>
