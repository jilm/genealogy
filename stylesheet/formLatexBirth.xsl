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
        Text mode
    -->

    <xsl:template
               match="birth[date and place]"
               mode="text">
        <xsl:variable name="place">
            <xsl:apply-templates select="place" mode="middle" />
        </xsl:variable>
        <xsl:variable name="date">
            <xsl:apply-templates select="date" />
        </xsl:variable>
        <xsl:value-of
                    select="concat($BIRTH-SYMBOL, ' ', $date, ', ', $place)" />
    </xsl:template>

    <xsl:template match="birth[date and not(place)]"
                  mode="text">
        <xsl:variable name="date">
            <xsl:apply-templates select="date" />
        </xsl:variable>
        <xsl:value-of select="concat($BIRTH-SYMBOL, ' ', $date)" />
    </xsl:template>

    <xsl:template match="birth[not(date) and place]"
                  mode="text">
        <xsl:variable name="place">
            <xsl:apply-templates select="place" mode="middle" />
        </xsl:variable>
        <xsl:value-of select="concat($BIRTH-SYMBOL, ' ', $place)" />
    </xsl:template>

    <!--
        Cite mode
    -->

    <xsl:template match="birth[date and place]" mode="cite" priority="3">
        <xsl:variable name="date">
            <xsl:apply-templates select="date" />
        </xsl:variable>
        <xsl:variable name="place">
            <xsl:apply-templates select="place" mode="middle" />
        </xsl:variable>
        <xsl:value-of select="concat($BIRTH-SYMBOL, ' ', $date, ' ', $place)" />
        <xsl:apply-templates select="cite" />
    </xsl:template>

    <xsl:template match="birth[date and not(place)]" mode="cite" priority="3">
        <xsl:variable name="date">
            <xsl:apply-templates select="date" />
        </xsl:variable>
        <xsl:value-of select="concat($BIRTH-SYMBOL, ' ', $date)" />
        <xsl:apply-templates select="cite" />
    </xsl:template>

    <xsl:template match="birth[not(date) and place]" mode="cite" priority="3">
        <xsl:variable name="place">
            <xsl:apply-templates select="place" mode="middle" />
        </xsl:variable>
        <xsl:value-of select="concat($BIRTH-SYMBOL, ' ', $place)" />
        <xsl:apply-templates select="cite" />
    </xsl:template>

    <xsl:template match="birth[not(date) and not(place)]"
                  mode="cite"
                  priority="3" />

    <xsl:template match="cite" priority="10">
        <xsl:text>, </xsl:text><xsl:next-match />
    </xsl:template>

    <!--
        Graph mode
    -->

  <xsl:template match="birth[date and place]" mode="graph">
    <xsl:variable name="date">
      <xsl:apply-templates select="date" />
    </xsl:variable>
    <xsl:variable name="place">
      <xsl:apply-templates select="place" />
    </xsl:variable>
    <xsl:value-of select="concat(jilm:get-birth-symbol(.), '~', $date, ', ', $place)" />
  </xsl:template>

  <xsl:template match="birth[date and not(place)]" mode="graph">
    <xsl:variable name="date">
      <xsl:apply-templates select="date" />
    </xsl:variable>
    <xsl:value-of select="concat(jilm:get-birth-symbol(.), '~', $date)" />
  </xsl:template>

  <xsl:template match="birth[not(date) and place]" mode="graph">
    <xsl:variable name="place">
      <xsl:apply-templates select="place" />
    </xsl:variable>
    <xsl:value-of select="concat(jilm:get-birth-symbol(.), '~', $place)" />
  </xsl:template>

  <xsl:function name="jilm:get-birth-symbol">
    <xsl:param name="birth-element" />
    <xsl:choose>
      <xsl:when test="$birth-element[@verified = 'true']">
        <xsl:value-of select="$ver-birth-symbol" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$birth-symbol" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>


</xsl:stylesheet>
