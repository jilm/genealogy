<?xml version="1.0" encoding="utf-8"?>

<!--


-->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:jilm="http://www.lidinsky.cz" >

    <xsl:template match="date" mode="#all">
        <xsl:variable name="date" select="jilm:analyze-date(text())" />
        <xsl:value-of select="concat($date/day/text(), '.', $date/month/text(), '.', $date/year/text())" />
    </xsl:template>

    <xsl:template match="date" mode="year" priority="2">
        <xsl:variable name="date" select="jilm:analyze-date(text())" />
        <xsl:value-of select="$date/year/text()" />
    </xsl:template>

    <xsl:template match="date" mode="long" priority="2">
        <xsl:variable name="date" select="jilm:analyze-date(text())" />
        <xsl:value-of select="concat($date/day/text(), '. ', $MONTH-LABELS-FULL[number($date/month/text())], ' ', $date/year/text())" />
    </xsl:template>

    <xsl:template match="date" mode="vmy" priority="2">
        <xsl:variable name="date" select="jilm:analyze-date(text())" />
        <xsl:value-of select="concat($MONTH-LABELS-FULL-V[number($date/month/text())], ' ', $date/year/text())" />
    </xsl:template>

</xsl:stylesheet>
