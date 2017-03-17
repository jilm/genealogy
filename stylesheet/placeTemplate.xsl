<?xml version="1.0" encoding="utf-8"?>

<!--

     A place could be entered as a chain of place elements which reference
     each other. This stylesheet collects all of the parts into the one
     place element. In other words it substitute referenced information
     on place of the reference.

-->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" encoding="utf-8" indent="yes" />

    <xsl:template match="place[text()]" priority="5">
        <place><xsl:apply-templates /></place>
    </xsl:template>

    <!-- 

         The highest level place template simply wraps content into the
         place element.

    -->
    <xsl:template match="place" priority="4">
        <xsl:variable name="place">
          <place>
            <xsl:next-match />
          </place>
        </xsl:variable>
        <place>
            <xsl:apply-templates select="$place/region" />
            <xsl:apply-templates select="$place/district" />
            <xsl:apply-templates select="$place/parish" />
            <xsl:apply-templates select="$place/house-nr" />
        </place>
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

    <xsl:template match="house-nr">
        <house-nr><xsl:apply-templates /></house-nr>
    </xsl:template>

</xsl:stylesheet>
