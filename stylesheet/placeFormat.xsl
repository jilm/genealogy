<?xml version="1.0" encoding="utf-8"?>

<!--

    Format a content of the place element into the textual form.

    short: Lukov 35

    middle: Lukov 35, okres Třebíč

-->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" encoding="utf-8" indent="yes" />

    <xsl:template match="place[text() and not(parish)]" priority="5">
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

</xsl:stylesheet>
