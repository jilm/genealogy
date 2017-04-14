<?xml version="1.0" encoding="utf-8"?>

<!--


-->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:jilm="http://www.lidinsky.cz" >


  <xsl:template match="birth[@cite]" priority="3" mode="cite" >
    <xsl:next-match /> viz \cite[scan: <xsl:value-of select="@scan" />]{<xsl:value-of select="@cite" />}
  </xsl:template>

  <xsl:template match="birth[normalize-space(date) and normalize-space(place)]">
    <xsl:variable name="place">
      <xsl:apply-templates select="place" mode="middle" />
    </xsl:variable>
    <xsl:value-of select="concat($BIRTH-SYMBOL, ' ', date, ', ', $place)" />
  </xsl:template>

  <xsl:template match="birth[normalize-space(date) and not(place)]">
    <xsl:value-of select="concat($BIRTH-SYMBOL, ' ', date)" />
  </xsl:template>

  <xsl:template match="birth[not(date) and normalize-space(place)]">
    <xsl:variable name="place">
      <xsl:apply-templates select="place" mode="middle" />
    </xsl:variable>
    <xsl:value-of select="concat($BIRTH-SYMBOL, ' ', $place)" />
  </xsl:template>

    <xsl:template match="birth[date and place]" mode="cite">
        <xsl:variable name="date">
            <xsl:apply-templates select="date" />
        </xsl:variable>
        <xsl:variable name="place">
            <xsl:apply-templates select="place" />
        </xsl:variable>
        <xsl:value-of select="concat($BIRTH-SYMBOL, $date, ', ', $place)" />
    </xsl:template>

</xsl:stylesheet>
