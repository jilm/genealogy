<?xml version="1.0" encoding="utf-8"?>

<!--


-->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:jilm="http://www.lidinsky.cz" >


    <xsl:template match="date[year and month and day]" mode="#default" priority="3">
        <xsl:value-of select="concat(day/text(), '.', month/text(), '.', year/text())" />
    </xsl:template>

    <xsl:template match="date[year and month]" mode="#default" priority="2">
        <xsl:value-of select="concat(month/text(), '.', year/text())" />
    </xsl:template>

    <xsl:template match="date[year and month and day]" mode="long text" priority="3">
        <xsl:variable name="day" select="day" />
        <xsl:variable name="month" select="month" />
        <xsl:variable name="year" select="year" />
        <xsl:value-of select="concat($day, '. ', $MONTH-LABELS-FULL[number($month)], ' ', $year)" />
    </xsl:template>

    <xsl:template match="date[year and month]" mode="long text" priority="2">
        <xsl:variable name="month" select="month" />
        <xsl:variable name="year" select="year" />
        <xsl:value-of select="concat($MONTH-LABELS-FULL[number($month)], ' ', $year)" />
    </xsl:template>

    <xsl:template match="date[year]" mode="#all" priority="1">
        <xsl:value-of select="year/text()" />
    </xsl:template>

    <xsl:template match="date[year and month]" mode="vmy" priority="2">
        <xsl:variable name="month" select="month" />
        <xsl:variable name="year" select="year" />
        <xsl:value-of select="concat($MONTH-LABELS-FULL-V[number($month)], ' ', $year)" />
    </xsl:template>

</xsl:stylesheet>
