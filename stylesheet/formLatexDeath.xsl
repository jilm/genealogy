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


    <xsl:template
               match="death[date and place]"
               mode="text">
        <xsl:variable name="place">
            <xsl:apply-templates select="place" mode="middle" />
        </xsl:variable>
        <xsl:variable name="date">
            <xsl:apply-templates select="date" />
        </xsl:variable>
        <xsl:value-of
                    select="concat($DEATH-SYMBOL, ' ', $date, ', ', $place)" />
    </xsl:template>

    <xsl:template match="death[date and not(place)]"
                  mode="text">
        <xsl:variable name="date">
            <xsl:apply-templates select="date" />
        </xsl:variable>
        <xsl:value-of select="concat($DEATH-SYMBOL, ' ', $date)" />
    </xsl:template>

    <xsl:template match="death[not(date) and place]"
                  mode="text">
        <xsl:variable name="place">
            <xsl:apply-templates select="place" mode="middle" />
        </xsl:variable>
        <xsl:value-of select="concat($DEATH-SYMBOL, ' ', $place)" />
    </xsl:template>

    <!--
        Cite mode
    -->

    <xsl:template match="death[date and place]" mode="cite" priority="3">
        <xsl:variable name="date">
            <xsl:apply-templates select="date" />
        </xsl:variable>
        <xsl:variable name="place">
            <xsl:apply-templates select="place" mode="middle" />
        </xsl:variable>
        <xsl:value-of select="concat($DEATH-SYMBOL, ' ', $date, ' ', $place)" />
        <xsl:apply-templates select="cite" />
    </xsl:template>

    <xsl:template match="death[date and not(place)]" mode="cite" priority="3">
        <xsl:variable name="date">
            <xsl:apply-templates select="date" />
        </xsl:variable>
        <xsl:value-of select="concat($DEATH-SYMBOL, ' ', $date)" />
        <xsl:apply-templates select="cite" />
    </xsl:template>

    <xsl:template match="death[not(date) and place]" mode="cite" priority="3">
        <xsl:variable name="place">
            <xsl:apply-templates select="place" mode="middle" />
        </xsl:variable>
        <xsl:value-of select="concat($DEATH-SYMBOL, ' ', $place)" />
        <xsl:apply-templates select="cite" />
    </xsl:template>

    <xsl:template match="death[not(date) and not(place)]"
                  mode="cite"
                  priority="3" />

    <xsl:template match="cite" priority="10">
        <xsl:text>, </xsl:text><xsl:next-match />
    </xsl:template>

    <!--
        Graph mode
    -->

  <xsl:template match="death[date and place]" mode="graph">
    <xsl:variable name="date">
      <xsl:apply-templates select="date" />
    </xsl:variable>
    <xsl:variable name="place">
      <xsl:apply-templates select="place" />
    </xsl:variable>
    <xsl:value-of select="concat(jilm:get-death-symbol(.), '~', $date, ', ', $place)" />
  </xsl:template>

  <xsl:template match="death[date and not(place)]" mode="graph">
    <xsl:variable name="date">
      <xsl:apply-templates select="date" />
    </xsl:variable>
    <xsl:value-of select="concat(jilm:get-death-symbol(.), '~', $date)" />
  </xsl:template>

  <xsl:template match="death[not(date) and place]" mode="graph">
    <xsl:variable name="place">
      <xsl:apply-templates select="place" />
    </xsl:variable>
    <xsl:value-of select="concat(jilm:get-death-symbol(.), '~', $place)" />
  </xsl:template>

  <xsl:function name="jilm:get-death-symbol">
    <xsl:param name="death-element" />
    <xsl:choose>
      <xsl:when test="$death-element[@verified = 'true']">
        <xsl:value-of select="$ver-death-symbol" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$death-symbol" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>


</xsl:stylesheet>
