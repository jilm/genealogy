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
               match="birth[normalize-space(date) and normalize-space(place)]"
               mode="text">
        <xsl:variable name="place">
            <xsl:apply-templates select="place" mode="middle" />
        </xsl:variable>
        <xsl:value-of
                     select="concat($BIRTH-SYMBOL, ' ', date, ', ', $place)" />
    </xsl:template>

    <xsl:template match="birth[normalize-space(date) and not(place)]"
                  mode="text">
        <xsl:value-of select="concat($BIRTH-SYMBOL, ' ', date)" />
    </xsl:template>

    <xsl:template match="birth[not(date) and normalize-space(place)]"
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
            <xsl:apply-templates select="place" />
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
            <xsl:apply-templates select="place" />
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

</xsl:stylesheet>
