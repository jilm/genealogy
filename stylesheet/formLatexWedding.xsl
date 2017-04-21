<?xml version="1.0" encoding="utf-8"?>

<!--

    Mode:
    * cite : full person list
    * text : 
    * graph :

-->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:jilm="http://www.lidinsky.cz" >

    <!--
        Graph mode
    -->

  <xsl:template match="wedding[date and place]" mode="graph">
    <xsl:variable name="date">
      <xsl:apply-templates select="date" />
    </xsl:variable>
    <xsl:variable name="place">
      <xsl:apply-templates select="place" />
    </xsl:variable>
    <xsl:value-of select="concat($married-symbol, '~', $date, ', ', $place)" />
  </xsl:template>

  <xsl:template match="wedding[date and not(place)]" mode="graph">
    <xsl:variable name="date">
      <xsl:apply-templates select="date" />
    </xsl:variable>
    <xsl:value-of select="concat($married-symbol, '~', $date)" />
  </xsl:template>

  <xsl:template match="wedding[not(date) and place]" mode="graph">
    <xsl:variable name="place">
      <xsl:apply-templates select="place" />
    </xsl:variable>
    <xsl:value-of select="concat($married-symbol, '~', $place)" />
  </xsl:template>

</xsl:stylesheet>
