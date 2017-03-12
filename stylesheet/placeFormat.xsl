<?xml version="1.0" encoding="utf-8"?>

<!--

    Format a content of the place element into the textual form.

    short: Lukov 35

    middle: Lukov 35, okres Třebíč

-->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" encoding="utf-8" indent="yes" />

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

    <!--

         Transform house number attribute into the element, if there
         is one.

    -->
    <xsl:template match="place[@house-nr]" priority="3" mode="#all" >
        <house-nr><xsl:value-of select="@house-nr" /></house-nr>
        <xsl:next-match />
    </xsl:template>

    <xsl:template match="place[@href]" priority="2" mode="#all">
        <xsl:variable name="ref" select="@href" />
        <xsl:apply-templates select="//place[@id = $ref]" mode="collect" />
        <xsl:next-match />
    </xsl:template>

    <xsl:template match="place" priority="1" mode="#all">
        <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="parish">
        <parish>
            <xsl:apply-templates />
        </parish>
    </xsl:template>

    <xsl:template match="region">
        <region>
            <xsl:apply-templates />
        </region>
    </xsl:template>

    <xsl:template match="district">
        <district>
            <xsl:apply-templates />
        </district>
    </xsl:template>

</xsl:stylesheet>
