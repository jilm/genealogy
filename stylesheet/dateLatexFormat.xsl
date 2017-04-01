<?xml version="1.0" encoding="utf-8"?>

<!--

    Format date for latex

    year:  1856
    short: 12.8.1974
    rome:  5.IV.1765
    long:  8. lendna 1685

-->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="date[text() and not(parish)]" priority="5">
        <xsl:apply-templates />
    </xsl:template>

    <!-- 

         The highest level place template simply wraps content into the
         place element.

    -->
    <xsl:template match="place[parish and house-nr]" priority="4">
        <xsl:variable name="parish">
            <xsl:apply-templates select="parish" />
        </xsl:variable>
        <xsl:variable name="house-nr">
            <xsl:apply-templates select="house-nr" />
        </xsl:variable>
        <xsl:value-of select="concat($parish, ' ', $house-nr)" />
    </xsl:template>

    <xsl:template match="place[parish]" priority="3" >
        <xsl:variable name="parish">
            <xsl:apply-templates select="parish" />
        </xsl:variable>
        <xsl:value-of select="$parish" />
    </xsl:template>

    <xsl:template match="place[parish and house-nr and district]" mode="middle" priority="5">
        <xsl:variable name="parish">
            <xsl:apply-templates select="parish" />
        </xsl:variable>
        <xsl:variable name="house-nr">
            <xsl:apply-templates select="house-nr" />
        </xsl:variable>
        <xsl:variable name="district">
            <xsl:apply-templates select="district" />
        </xsl:variable>
        <xsl:value-of select="concat($parish, ' ', $house-nr, ' okres ', $district)" />
    </xsl:template>

    <xsl:template match="parish">
        <xsl:value-of select="." />
    </xsl:template>

    <xsl:template match="house-nr">
        <xsl:value-of select="." />
    </xsl:template>

    <xsl:template match="district">
        <xsl:value-of select="." />
    </xsl:template>

</xsl:stylesheet>
